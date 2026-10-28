# Keep editable content in data/collections, separate from build and layout settings.
require "nokogiri"

module SuLab
  class ContentSettings < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      settings = site.data.fetch("settings", {})
      %w[title subtitle description].each { |key| site.config[key] = settings[key] if settings.key?(key) }
      site.config["header"] = settings["header_image"]
      site.config["footer"] = settings["footer_image"]
      paths = {"index.md" => "home", "research/index.md" => "research", "team/index.md" => "people", "publications/index.md" => "publications", "lab-photos/index.md" => "photos", "join-us/index.md" => "join", "contact/index.md" => "contact"}
      site.pages.each do |page|
        key = paths[page.path]
        content = site.data.fetch("pages", {})[key] if key
        page.data["title"] = content["title"] if content
      end
    end
  end

  module ContentFilters
    # CMS stores portable /images/... paths. Resolve them under the Pages subpath
    # at render time, including images inserted in the rich-text editor.
    def render_content(value)
      return "" if value.nil? || value.to_s.strip.empty?
      site = @context.registers[:site]
      rendered = site.find_converter_instance(Jekyll::Converters::Markdown).convert(value.to_s)
      fragment = Nokogiri::HTML.fragment(rendered)
      fragment.css("[src], [href]").each do |node|
        %w[src href].each do |attribute|
          path = node[attribute]
          next unless path && (path.start_with?("/", "images/") && !path.start_with?("//"))
          base = site.baseurl.to_s.sub(%r{/$}, "")
          next if !base.empty? && (path == base || path.start_with?(base + "/"))
          node[attribute] = base + "/" + path.sub(%r{^/}, "")
        end
      end
      fragment.to_html
    end
  end
end
Liquid::Template.register_filter(SuLab::ContentFilters)
