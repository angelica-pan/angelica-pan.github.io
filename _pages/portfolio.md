---
layout: page
title: Portfolio
permalink: /portfolio/
---

<div class="container" data-aos="fade-up" data-aos-easing="ease-out-quad" data-aos-duration="800">
  {% assign sorted = site.portfolio | sort: "order" %}
  {% for item in sorted %}
  <div class="article">
    {% if item.image %}
    <div class="article__image-box">
      <a href="{{item.url | prepend: site.baseurl}}" class="article__image" style="background-image: url({{site.baseurl}}{{item.image}})"></a>
    </div>
    {% endif %}
    <div class="article__content">
      <h1 class="article__title">
        <a href="{{ item.url | prepend: site.baseurl }}">{{ item.title }}</a>
      </h1>
      <div class="article__meta">
        <span class="article__date">
          <time datetime="{{ item.start_date | date_to_xmlschema }}">{% assign date_format = "%B %Y" %}{{ item.start_date | start_date: date_format }}</time> - {{ item.end_date }}
        </span>
      </div>
      <p class="article__excerpt">
          {% if item.description %}{{ item.description }}{% else %}{{ item.content | strip_html | truncate: 130 }}{% endif %}
      </p>
    </div>
  </div>
  {% endfor %}
</div>