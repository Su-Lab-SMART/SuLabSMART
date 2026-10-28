---
title: People
nav:
  order: 3
redirect_from:
  - /people/
---

# People

{% assign current_members = site.members | where: "status", "current" | sort: "order" %}
{% for member in current_members %}
{% include member-bio.html member=member %}
{% endfor %}

{% include section.html %}

<h2>Awards to lab members</h2>

<ul>
  <li><strong>Renny Ng: </strong>2024-26 UC San Diego PiBS Training Program; 2024-26 ARCS Foundation Fellowship Award</li>
  <li><strong>Jonathan Choy: </strong>2023 Eureka! Research Scholarship, UCSD Summer Research Program</li>
  <li><strong>Shiuan-Tze Wu</strong>: 2022 Neural Circuits T32 Training Program; 2020 Kavli-Helinski Endowed Fellowship, Division of Biological Sciences, UCSD;  2019 AChemS Student Travel and Housing Award</li>
  <li><strong>Allie Williams</strong>: 2022 Summer CAMP program, funded by the National Science Foundation (NSF) and part of the California Alliance for Minority Participation (CAMP)</li>
  <li><strong>Ye Zhang</strong>: 2018 Goeddel Endowed Award, Division of Biological Sciences, UCSD</li>
  <li><strong>Cesar Nava Gonzales</strong>: 2019 TRELS Scholarship, UCSD; 2018 Eureka! Research Scholarship, UCSD Summer Research Program</li>
  <li><strong>Tin Ki Tsang</strong>: 2017 Frontiers of Innovation Scholars Program; 2016 Goeddel Endowed Award, Division of Biological Sciences, UCSD; 2015 Croucher Foundation Scholarship, Hong Kong</li>
  <li><strong>Wilmer A Del-cid</strong>: 2014 UC San Diego Genetics Training Program</li>
  <li><strong>Lisa Mai</strong>: 2014 Eureka! Research Scholarship, UCSD Summer Research Program</li>
</ul>

<h2>Alumni</h2>

<ul>
  <li><a href="{{ '/members/kalyani-cauwenberghs.html' | relative_url }}">Kalyani Cauwenberghs</a>, Lab Assistant (2023-26)/Undergraduate Student (2020-23)</li>
  <li><a href="{{ '/members/jessica-xiong.html' | relative_url }}">Jessica Xiong</a>, Undergraduate Student (2024-26)</li>
  <li><a href="{{ '/members/muskaan-garg.html' | relative_url }}">Muskaan Garg</a>, Undergraduate Student (2024-26)</li>
  <li><a href="{{ '/members/margarita-bellah.html' | relative_url }}">Margarita Bellah</a>, Lab Manager (2021-26)</li>
  <li>Yiyi Xiao, Lab Assistant (2024-25)/Undergraduate Student (2021-24)</li>
  <li>Jonathan Choy, Lab Assistant (2024-25)/Undergraduate Student (2021-24)</li>
  <li>Shadi Charara, Lab Assistant (2024-25)/Undergraduate Student (2022-24)</li>
  <li>Jasmine Cheng, Undergraduate Student (2023-24)</li>
  <li>Runqi Zhang, Lab Assistant (2023-24)/Undergraduate Student (2021-23)</li>
  <li>Jamie Ho, Undergraduate Student and BSMS Student (2022-24)</li>
  <li>Shiuan-Tze Wu, Postdoctoral Fellow (2022-23)/Graduate Student (2017-22)</li>
  <li>Allie Williams, Undergraduate Student (2022-23)</li>
  <li>Vanessa Martin, Lab Assistant (2020-2022)/BSMS Student (2018-20)</li>
  <li>Quintyn McKaughan, Lab Assistant (2020-22)</li>
  <li>Ye Zhang, Graduate Student (2016-20)</li>
  <li>Xiongxiong Zhang, Lab Mascot (2016-20)</li>
  <li>Neghin Jafarzadeh, Lab Manager (2013-20)</li>
  <li>Cesar Nava Gonzales, Lab Assistant (2019-20)/Undergraduate Student (2017-19)</li>
  <li>Zixian Huang, Undergraduate Student (2020)</li>
  <li>Angela Tsang, Graduate Student (2014-18)</li>
  <li>Jen-Yung Chen, Postdoctoral Fellow (2016-18)</li>
  <li>Secilia Salem, Undergraduate Student (2015-18)</li>
  <li>Vivian Nguyen, Undergraduate Student (2017-18)</li>
  <li>Edie Zhang, Undergraduate Student (2017-18)</li>
  <li>Martin Orden, Undergraduate Student (2017-18)</li>
  <li>Titus Tsai, High School Summer Intern (2018)</li>
  <li>Tiffany Tsai, High School Summer Intern (2017, 2018)</li>
  <li>Szu Ying Chen, Undergraduate Student (2017)</li>
  <li>Wilmer Del-cid, Graduate Student (2014-17)</li>
  <li>Boqian Wang, Undergraduate Summer Intern (2014)</li>
  <li>Lisa Mai, Undergraduate Student (2013-14)</li>
  <li>Tricia Ngo, Lab Assistant (2013-14)</li>
</ul>
