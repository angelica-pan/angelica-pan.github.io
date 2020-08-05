---
layout: page
title: projects
permalink: /projects/
---
{% for project in site.projects %}
  <div class="sm-width-full project py-2"> 
    {% if project.thumbnail %}
      <a href="{{ project.url }}"><img src="{{ project.thumbnail }}" alt="{{ project.title }}" width="200" height="200" /></a>
    {% endif %}
    <h1><a href="{{ project.url }}">{{ project.title }}</a></h1>
    <div class="project-blurb prose px-3">
      {{ project.blurb }}
    </div>
  </div>
{% endfor %}
