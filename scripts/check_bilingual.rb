require 'nokogiri'
require 'yaml'
root = File.expand_path('..', __dir__)
site = File.join(root, '_site')
base = '/SuLabSMART'
assert = lambda { |ok, message| abort message unless ok }
read = lambda { |path| Nokogiri::HTML(File.read(File.join(site, path))) }
paths = %w[index.html research/index.html team/index.html publications/index.html lab-photos/index.html join-us/index.html contact/index.html]
paths += Dir[File.join(root, '_members/*.md')].map { |p| "members/#{File.basename(p, '.md')}.html" }
paths.each do |path|
  en, zh = read.call(path), read.call('zh/' + path)
  url = '/' + path.sub(/index\.html$/, '')
  assert.call(en.at_css('html')['lang'] == 'en' && zh.at_css('html')['lang'] == 'zh-Hans', "Incorrect language: #{path}")
  assert.call(en.at_css('.language-switch')['href'] == base + '/zh' + url, "English switch target: #{path}")
  assert.call(zh.at_css('.language-switch')['href'] == base + url, "Chinese switch target: #{path}")
  assert.call(zh.at_css('link[rel="canonical"]')['href'].end_with?(base + '/zh' + url), "Canonical URL: #{path}")
  assert.call(zh.at_css('link[hreflang="en"]') && zh.at_css('link[hreflang="zh-Hans"]'), "Missing alternate metadata: #{path}")
  zh.css('header nav a').reject { |node| node['class'] == 'language-switch' }.each { |node| assert.call(node['href'].start_with?(base + '/zh/'), "Chinese navigation escapes language: #{path}") }
end
assert.call(read.call('zh/index.html').at_css('h1').text.include?('欢迎'), 'Chinese home template missing')
assert.call(read.call('zh/contact/index.html').at_css('h1').text.include?('联系'), 'Chinese contact template missing')
research = read.call('zh/research/index.html')
assert.call(research.css('h2').length == 4 && research.text.include?('无突触相互作用'), 'Chinese research topics missing')
assert.call(research.css('sup').any? { |node| node.text == 'MC' }, 'Chinese scientific superscripts missing')
profile = read.call('zh/members/chih-ying-su.html')
assert.call(profile.at_css('h1').text == 'Chih-Ying Su' && profile.text.include?('资深研究员'), 'Localized profile name/body missing')
{'team/index.html'=>'.member-bio','lab-photos/index.html'=>'.lab-photo','publications/index.html'=>'.publication-entry'}.each do |path, selector|
 en,zh=read.call(path),read.call('zh/'+path)
 assert.call(en.css(selector).length == zh.css(selector).length, "Shared record count mismatch: #{path}")
 assert.call(en.css('main img').map { |n| n['src'] } == zh.css('main img').map { |n| n['src'] }, "Images duplicated or altered: #{path}")
end
puts 'Bilingual pages, matching switches, localized navigation, shared records/images, profiles, scientific typography, and SEO: PASS'
