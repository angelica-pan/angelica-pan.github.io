---
layout: page
title: Portfolio
permalink: /portfolio/
---

<div class="container" data-aos="fade-up" data-aos-easing="ease-out-quad" data-aos-duration="800">
  {% for item in site.portfolio %}
  <a href="{{ item.url | prepend: site.baseurl }}">
  <div class="portfolio-item">
    <div class="portfolio-thumbnail">
      <img src="{{ item.thumbnail | prepend: site.baseurl }}" alt="{{ item.title }}" class="portfolio-border">
    </div>
    <div class="portfolio-text">
      <h2 class="no-margin"><b>{{item.title}}</b></h2>
      <p>{{ item.blurb }}</p>
    </div>
  </div>
  </a>
  {% endfor %}
</div>
