---
layout: page
title: portfolio
permalink: /portfolio/
---
<!-- use "col-4" for 3 posts per row, and "col-6" for 2 posts per row -->
{% for project in site.projects %}
  <div class="sm-width-full project col-4 py-2"> 
    {% if project.thumbnail %}
      <a href="{{ project.url }}"><img src="{{ project.thumbnail }}" alt="{{ project.title }}" width="200" height="200" /></a>
    {% endif %}
    <h1><a href="{{ project.url }}">{{ project.title }}</a></h1>
    <div class="centering-container prose px-3">
      {{ project.blurb }}
    </div>
  </div>
{% endfor %}
