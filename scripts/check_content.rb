# Validate both editable source data and the rendered GitHub Pages website.
require "yaml"
require "json"
require "nokogiri"
require "uri"
require "pathname"

root = File.expand_path("..", __dir__)
Dir.chdir(root)
config = YAML.safe_load(File.read(".pages.yml"))
errors = []
entries = []
walk = lambda do |items|
  items.each do |entry|
    entry["type"] == "group" ? walk.call(entry.fetch("items")) : entries << entry
  end
end
walk.call(config.fetch("content"))

entries.each do |entry|
  fields = entry.fetch("fields")
  paths = entry["type"] == "collection" ? Dir.glob("#{entry['path']}/*.md") : [entry.fetch("path")]
  paths.each do |path|
    if path.end_with?(".json")
      data = JSON.parse(File.read(path))
    else
      match = File.read(path).match(/\A---\s*\n(.*?)\n---\s*\n?(.*)\z/m)
      abort "Missing frontmatter in #{path}" unless match
      data = YAML.safe_load(match[1]).merge("body" => match[2].strip)
    end
    check_fields = lambda do |definitions, value, location|
      definitions.each do |field|
        current = value[field["name"]]
        label = "#{location}.#{field['name']}"
        errors << "Required field is empty: #{label}" if field["required"] && (current.nil? || current.to_s.strip.empty?)
        Array(field["list"] ? current : [current]).each do |item|
          next if item.nil?
          if field["type"] == "object"
            check_fields.call(field.fetch("fields"), item, label)
          elsif field["type"] == "image" && item != ""
            local = item.sub(%r{^/}, "")
            errors << "Missing image: #{label}: #{item}" unless File.file?(local)
          elsif field["type"] == "rich-text"
            errors << "Template code in editable content: #{label}" if item.match?(/\{%|\{\{/)
            fragment = Nokogiri::HTML.fragment(item)
            errors << "Layout markup in editable content: #{label}" unless fragment.css("div, section, style, script, [class], [style]").empty?
          end
        end
      end
      unknown = value.keys - definitions.map { |field| field["name"] }
      errors << "Fields missing from CMS: #{location}: #{unknown.join(', ')}" unless unknown.empty?
    end
    check_fields.call(fields, data, path)
  end
end

site = File.join(root, "_site")
base = "/SuLabTest1022"
Dir.glob("#{site}/**/*.html").each do |file|
  document = Nokogiri::HTML(File.read(file))
  errors << "Repeated page heading: #{file}" if document.css("main h1").length > 1
  document.css("a[href], img[src], link[href], script[src]").each do |element|
    url = element["href"] || element["src"]
    next if url.nil? || url.empty? || url.start_with?("#", "//") || url.match?(%r{\A[a-zA-Z][a-zA-Z0-9+.-]*:})
    path = url.split(/[?#]/, 2).first
    next if path.nil? || path.empty?
    if path.start_with?(base + "/")
      target = File.join(site, URI::DEFAULT_PARSER.unescape(path.delete_prefix(base + "/")))
    elsif path.start_with?("/")
      errors << "Link escapes the GitHub Pages subpath: #{file}: #{url}"
      next
    else
      target = File.expand_path(URI::DEFAULT_PARSER.unescape(path), File.dirname(file))
    end
    errors << "Broken local resource: #{file}: #{url}" unless File.exist?(target)
  end
  document.css('script[type="application/ld+json"]').each { |script| JSON.parse(script.text) }
end

Dir.glob("#{site}/_styles/*.css").each do |file|
  errors << "HTML layout leaked into CSS: #{file}" if File.read(file).match?(/<!DOCTYPE|<html|<header/i)
end

checks = {"team/index.html" => [".member-bio", Dir.glob("_members/*.md").count { |path| File.read(path).match?(/^status: current$/) }], "lab-photos/index.html" => [".lab-photo", Dir.glob("_photos/*.md").length], "publications/index.html" => [".publication-entry", Dir.glob("_publications/*.md").length]}
checks.each do |page, (selector, expected)|
  actual = Nokogiri::HTML(File.read(File.join(site, page))).css(selector).length
  errors << "Record count mismatch on #{page}: #{actual}, expected #{expected}" unless actual == expected
end
abort errors.join("\n") unless errors.empty?
puts "CMS field coverage, required data, image paths, rendered record counts, metadata JSON, and internal links: PASS"
