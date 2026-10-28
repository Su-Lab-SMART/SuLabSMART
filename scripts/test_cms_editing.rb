# Exercise representative content-only edits, then restore every source file.
require "jekyll"
require "json"
require "yaml"
require "nokogiri"
require "tmpdir"

root = File.expand_path("..", __dir__)
Dir.chdir(root)
Jekyll.logger.writer.instance_variable_set(:@level_override, {}) # Ruby 3.3 local compatibility
originals = {}
write = lambda do |path, text|
  originals[path] = File.exist?(path) ? File.binread(path) : nil unless originals.key?(path)
  File.write(path, text)
end
record = lambda do |path, fields, body|
  write.call(path, "---\n" + fields.to_yaml.sub(/\A---\s*\n/, "") + "---\n\n" + body)
end
assert = lambda { |condition, message| raise message unless condition }
begin
  settings = JSON.parse(File.read("_data/settings.json"))
  settings["title"] = 'Lab "CMS" test'
  settings["navigation"].reverse!
  write.call("_data/settings.json", JSON.pretty_generate(settings))
  home = JSON.parse(File.read("_data/pages/home.json"))
  home["introduction"] = '<p>CMS edit — CO₂, Fruᴹꟲ. <a href="/team/">People</a></p><p><img src="/images/background.jpg" alt="CMS upload"></p><p><img src="/SuLabTest1022/images/icon.png" alt="Already prefixed"></p>'
  write.call("_data/pages/home.json", JSON.pretty_generate(home))
  # A former current member should move groups without changing their URL.
  write.call("_members/pawel-vijayakumar.md", File.read("_members/pawel-vijayakumar.md").sub("status: current", "status: alumni"))
  record.call("_members/cms-integration-fixture.md", {"name" => "CMS Integration Member", "description" => "Researcher", "status" => "current", "order" => 0, "image" => "/images/icon.png", "emails" => ["test@example.org"]}, '<p>A <strong>formatted biography</strong>.</p>')
  record.call("_photos/cms-integration-fixture.md", {"title" => "CMS Integration Photo", "image" => "/images/background.jpg", "alt" => "CMS fixture", "date_label" => "October 2026", "order" => 0}, '<p>A new caption.</p>')
  record.call("_publications/cms-integration-fixture.md", {"title" => "CMS Integration Paper", "authors" => "Test Author", "year" => 2099, "journal" => "Test Journal", "order" => 0}, '')
  record.call("_research/cms-integration-fixture.md", {"title" => "CMS Integration Research", "order" => 0}, '<p>Editable scientific description.</p>')
  record.call("_awards/cms-integration-fixture.md", {"name" => "CMS Integration Award", "order" => 0}, '<p>New award details.</p>')
  record.call("_pages/cms-integration-fixture.md", {"title" => "CMS Integration Page"}, '<p>A new standalone page.</p>')
  Dir.mktmpdir("sulab-cms-editing-") do |destination|
    site = Jekyll::Site.new(Jekyll.configuration({"source" => root, "destination" => destination, "baseurl" => "/SuLabTest1022", "quiet" => true}))
    site.process
    page = lambda { |path| Nokogiri::HTML(File.read(File.join(destination, path))) }
    home_page = page.call("index.html")
    assert.call(home_page.at_css('img[alt="CMS upload"]')["src"] == "/SuLabTest1022/images/background.jpg", "Rich-text upload path is incorrect")
    assert.call(home_page.at_css('img[alt="Already prefixed"]')["src"] == "/SuLabTest1022/images/icon.png", "Image subpath was duplicated")
    assert.call(home_page.at_css('a[href="/SuLabTest1022/team/"]'), "Rich-text internal link was not resolved")
    assert.call(home_page.text.include?("CO₂, Fruᴹꟲ"), "Scientific characters changed")
    assert.call(home_page.at_css("header nav a").text.strip == "Join Us", "Navigation ordering was not applied")
    JSON.parse(home_page.at_css('script[type="application/ld+json"]').text)
    people = page.call("team/index.html")
    assert.call(people.css(".member-bio").first.text.include?("CMS Integration Member"), "New member / ordering missing")
    assert.call(people.css(".member-bio").none? { |node| node.text.include?("Pawel Vijayakumar") }, "Alumni switch did not remove current profile")
    assert.call(people.at_css(".alumni-list").text.include?("Pawel Vijayakumar"), "Alumni switch lost member")
    assert.call(people.at_css(".awards-list").text.include?("CMS Integration Award"), "New award missing")
    assert.call(page.call("lab-photos/index.html").at_css(".lab-photo").text.include?("A new caption"), "New photo / caption / ordering missing")
    assert.call(page.call("publications/index.html").at_css(".publication-entry").text.include?("CMS Integration Paper"), "New publication / year grouping missing")
    assert.call(page.call("research/index.html").text.include?("CMS Integration Research"), "New research topic missing")
    assert.call(page.call("pages/cms-integration-fixture/index.html").text.include?("A new standalone page"), "New standalone page missing")
    assert.call(File.file?(File.join(destination, "members/pawel-vijayakumar.html")), "Existing member URL changed")
  end
  puts "Content-only editing: new records, membership changes, sort order, standalone pages, rich-text uploads, scientific characters, and quoted metadata: PASS"
ensure
  originals.each do |path, text|
    text.nil? ? File.delete(path) : File.binwrite(path, text)
  end
end
