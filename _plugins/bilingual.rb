# Generate paired language pages from one source and one set of shared records.
module SuLab
  module Bilingual
    PAGE_KEYS = {"index.md" => "home", "research/index.md" => "research", "team/index.md" => "people", "publications/index.md" => "publications", "lab-photos/index.md" => "photos", "join-us/index.md" => "join", "contact/index.md" => "contact"}.freeze
    def self.present?(value)
      !value.nil? && !(value.respond_to?(:empty?) && value.empty?) && !value.to_s.strip.empty?
    end
  end

  class BilingualPages < Jekyll::Generator
    safe true
    priority :low
    def generate(site)
      sources = site.pages.select { |p| Bilingual::PAGE_KEYS.key?(p.path) }
      sources += %w[members custom_pages].flat_map { |key| site.collections.fetch(key).docs }
      site.config["bilingual_paths"] = sources.map(&:url)
      sources.each do |source|
        en_url = source.url
        zh_url = "/zh#{en_url}"
        source.data.merge!({"lang" => "en", "html_lang" => "en", "english_url" => en_url, "chinese_url" => zh_url, "alternate_url" => zh_url, "alternate_lang" => "zh-Hans"})
        # A file Page keeps the shared content in Liquid while getting a distinct URL.
        directory = en_url.end_with?("/") ? zh_url : File.dirname(zh_url)
        filename = en_url.end_with?("/") ? "index.html" : File.basename(zh_url)
        copy = Jekyll::PageWithoutAFile.new(site, site.source, directory, filename)
        copy.content = source.content
        copy.data = source.data.dup
        copy.data.delete("redirect_from")
        copy.data.merge!({"permalink" => zh_url, "lang" => "zh", "html_lang" => "zh-Hans", "alternate_url" => en_url, "alternate_lang" => "en"})
        key = Bilingual::PAGE_KEYS[source.path]
        if key
          copy.data["title"] = site.data.fetch("pages_zh").fetch(key).fetch("title")
        else
          copy.data["content"] = source.content
          copy.data["profile_name"] = source.data["name"] if source.data["name"]
          copy.data["title"] ||= source.data["name"]
          translated = source.data.fetch("zh", {})
          copy.data["title"] = translated["name"] if Bilingual.present?(translated["name"])
          %w[name title description].each { |field| copy.data[field] = translated[field] if Bilingual.present?(translated[field]) }
        end
        site.pages << copy
      end
    end
  end

  module BilingualFilters
    def chinese?
      @context["page"]["lang"] == "zh"
    end

    def bilingual_record(item)
      return item unless chinese? && item
      data = item.respond_to?(:to_h) ? item.to_h.dup : item.dup
      data["name"] = item["profile_name"] if item["profile_name"]
      translated = item["zh"] || {}
      translated.each { |key, value| data[key] = value if key != "body" && key != "translation_status" && Bilingual.present?(value) }
      original = item["content"].to_s
      if Bilingual.present?(translated["body"])
        data["content"] = translated["body"]
      else
        data["content"] = original
        data["translation_missing"] = !Nokogiri::HTML.fragment(original).text.strip.empty?
      end
      data
    end

    def localize_page(item, key)
      chinese? ? @context.registers[:site].data.fetch("pages_zh").fetch(key) : item
    end

    def localized_url(value)
      return value unless chinese? && value
      site = @context.registers[:site]
      path, suffix = value.to_s.split(/(?=[?#])/, 2)
      base = site.baseurl.to_s
      path = path.delete_prefix(base) if !base.empty? && path.start_with?(base + "/")
      site.config.fetch("bilingual_paths", []).include?(path) ? "/zh#{path}#{suffix}" : value
    end
  end
end
Liquid::Template.register_filter(SuLab::BilingualFilters)
