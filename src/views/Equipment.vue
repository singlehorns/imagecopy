<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import PageHero from '../components/PageHero.vue'
import { equipment } from '../data/equipment'
const equipmentList = ref(null)
let observer
let frame
onMounted(() => {
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches || !('IntersectionObserver' in window)) return
  const rows = equipmentList.value.querySelectorAll('.equipment-row')
  observer = new IntersectionObserver(entries => {
    entries.forEach(({ target, isIntersecting }) => {
      if (!isIntersecting) return
      target.classList.remove('flip-pending')
      observer.unobserve(target)
    })
  }, { threshold: 0.08, rootMargin: '0px 0px -24px 0px' })
  rows.forEach(row => row.classList.add('flip-pending'))
  frame = requestAnimationFrame(() => {
    frame = requestAnimationFrame(() => rows.forEach(row => observer.observe(row)))
  })
})
onBeforeUnmount(() => { cancelAnimationFrame(frame); observer?.disconnect() })
</script>
<template>
  <PageHero eyebrow="OUR EQUIPMENT" title="專業設備" description="以合適的設備，完成從文件、圖面到成品的輸出需求。"/>
  <section ref="equipmentList" class="container equipment-list">
    <article v-for="(e,i) in equipment" :key="e[0]" class="equipment-row">
      <div class="equipment-image"><img :src="e[2]" :alt="e[0]"></div>
      <div><p class="eyebrow">EQUIPMENT 0{{i+1}}</p><h2>{{e[0]}}</h2><p>{{e[1]}}</p></div>
    </article>
  </section>
</template>
<style scoped>
.equipment-row{transform-origin:center top;transform:perspective(1200px) rotateX(0deg);opacity:1;transition:transform .95s cubic-bezier(.22,.61,.36,1),opacity .7s ease}
.equipment-row.flip-pending{transform:perspective(1200px) rotateX(-65deg);opacity:0}
@media(prefers-reduced-motion:reduce){.equipment-row,.equipment-row.flip-pending{transform:none;opacity:1;transition:none}}
</style>
