---
title: Team
nav:
  order: 3
  tooltip: Current members of the Su Lab
---

# {% include icon.html icon="fa-solid fa-users" %}Team

Our team studies olfactory neuroscience, from the activity of individual sensory neurons to the structure of the circuits they form. The profiles below introduce current members of the Su Lab.

{% include section.html %}

{% include list.html data="members" component="portrait" filter="role == 'principal-investigator'" %}
{% include list.html data="members" component="portrait" filter="role != 'principal-investigator'" %}
