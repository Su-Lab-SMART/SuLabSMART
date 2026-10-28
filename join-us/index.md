---
---
{% assign info = site.data.pages.join %}
<h1>{{ info.heading | escape }}</h1>
<h2>{{ info.section_heading | escape }}</h2>
{{ info.introduction | render_content }}
{% if info.show_contact_emails %}
<p>{{ info.contact_prompt | escape }} {% for email in site.data.contact.emails %}<a href="mailto:{{ email.address | escape }}">{{ email.label | default: email.address | escape }}</a>{% unless forloop.last %} · {% endunless %}{% endfor %}.</p>
{% endif %}
