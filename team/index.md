---
redirect_from:
  - /people/
---
{% assign info = site.data.pages.people %}
<h1>{{ info.heading | escape }}</h1>
{{ info.introduction | render_content }}
{% assign current_members = site.members | where: 'status', 'current' | sort: 'order' %}
{% for member in current_members %}{% include member-bio.html member=member %}{% endfor %}
{% include section.html %}
<h2>{{ info.awards_heading | escape }}</h2>
{% assign awards = site.awards | sort: 'order' %}
<ul class="awards-list">{% for award in awards %}<li><strong>{{ award.name | escape }}:</strong> {{ award.content | render_content }}</li>{% endfor %}</ul>
<h2>{{ info.alumni_heading | escape }}</h2>
{% assign alumni = site.members | where: 'status', 'alumni' | sort: 'order' %}
<ul class="alumni-list">{% for member in alumni %}<li><a href="{{ member.url | relative_url }}">{{ member.name | escape }}</a>{% if member.history and member.history != '' %}, {{ member.history | escape }}{% endif %}</li>{% endfor %}</ul>
