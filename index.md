---
layout: default
---

<div class="container">
  <!-- begin author -->
  <section class="author">
    <div class="author__inner">
    <img src="{{site.baseurl}}{{site.author.image}}" alt="{{site.author.name}}" class="author__img">
      <h1 class="author__name">{{ site.author.name }}</h1>
      <p class="author__bio">{{ site.author.bio }}</p>
      <div class="author__more">
        <a href="mailto:{{site.author.email}}" class="say-hello">Contact me</a>
      </div>
    </div>
  </section>
  <!-- end author -->
</div>
