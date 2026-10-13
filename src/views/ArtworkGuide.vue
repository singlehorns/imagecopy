<script setup>
import PageHero from '../components/PageHero.vue'
import { guide } from '../data/artworkGuide.js'
import { ref, onMounted, onBeforeUnmount } from 'vue'
const guideLayout = ref(null)
let observer
let frame
onMounted(() => {
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches || !('IntersectionObserver' in window)) return
  const articles = guideLayout.value.querySelectorAll('.guide-content article')
  observer = new IntersectionObserver(entries => {
    entries.filter(entry => entry.isIntersecting).forEach(({ target }, index) => {
      target.style.setProperty('--guide-delay', `${Math.min(index, 3) * 100}ms`)
      target.classList.remove('guide-pending')
      observer.unobserve(target)
    })
  }, { threshold: 0, rootMargin: '0px 0px -24px 0px' })
  articles.forEach(article => article.classList.add('guide-pending'))
  frame = requestAnimationFrame(() => {
    frame = requestAnimationFrame(() => articles.forEach(article => observer.observe(article)))
  })
})
onBeforeUnmount(() => { cancelAnimationFrame(frame); observer?.disconnect() })
</script>
<template>
  <PageHero eyebrow="ARTWORK GUIDE" title="完稿須知" description="請依照印象行原有輸出與印刷完稿規範準備檔案。"/>
  <section ref="guideLayout" class="container guide-layout">
    <aside><a v-for="g in guide" :key="g[0]" :href="'#'+g[0]">{{g[0]}}</a></aside>
    <div class="guide-content"><article v-for="(g,index) in guide" :key="g[0]" :id="g[0]"><span class="guide-index">{{String(index+1).padStart(2,'0')}}</span><div><h2>{{g[0]}}</h2><p>{{g[1]}}</p></div></article></div>
  </section>
</template>
<style scoped>
.guide-content article{opacity:1;transform:translateY(0);transition:opacity .7s ease var(--guide-delay,0ms),transform .7s cubic-bezier(.22,.61,.36,1) var(--guide-delay,0ms);scroll-margin-top:110px}
.guide-content article.guide-pending{opacity:0;transform:translateY(28px)}
@media(prefers-reduced-motion:reduce){.guide-content article{opacity:1!important;transform:none!important;transition:none!important}}
</style>
