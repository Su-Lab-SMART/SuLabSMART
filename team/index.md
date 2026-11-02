---
redirect_from:
  - /people/
---
{% assign info = site.data.pages.people | localize_page: 'people' %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign current_members = site.members | where: 'status', 'current' | sort: 'order' %}
{% for member in current_members %}{% assign localized_member = member | bilingual_record %}{% include member-bio.html member=localized_member %}{% endfor %}
{% include section.html %}
<h2>{{ info.awards_heading | escape }}</h2>
{% assign awards = site.awards | sort: 'order' %}
<ul class="awards-list">{% for award in awards %}{% assign localized_award = award | bilingual_record %}<li><strong>{{ localized_award.name | escape }}:</strong> {% include translation-notice.html item=localized_award %}{{ localized_award.content | render_content }}</li>{% endfor %}</ul>
<h2>{{ info.alumni_heading | escape }}</h2>
{% assign alumni = site.members | where: 'status', 'alumni' | sort: 'order' %}
<ul class="alumni-list">{% for member in alumni %}{% assign localized_member = member | bilingual_record %}<li><a href="{{ localized_member.url | localized_url | relative_url }}">{{ localized_member.name | escape }}</a>{% if localized_member.history and localized_member.history != '' %}, {{ localized_member.history | escape }}{% endif %}</li>{% endfor %}</ul>
