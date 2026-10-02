<script setup>
import PageHero from '../components/PageHero.vue'
import { guide } from '../data/artworkGuide.js'
const scrollToTop = () => window.scrollTo({ top: 0, behavior: 'smooth' })
</script>
<template>
  <PageHero eyebrow="ARTWORK GUIDE" title="完稿須知" description="請依照印象行原有輸出與印刷完稿規範準備檔案。"/>
  <section class="container guide-layout">
    <aside><a v-for="g in guide" :key="g[0]" :href="'#'+g[0]">{{g[0]}}</a></aside>
    <div class="guide-content"><article v-for="(g,index) in guide" :key="g[0]" :id="g[0]"><span class="guide-index">{{String(index+1).padStart(2,'0')}}</span><div><h2>{{g[0]}}</h2><p>{{g[1]}}</p></div></article></div>
  </section>
  <button class="guide-back-to-top" type="button" aria-label="回到頂部" @click="scrollToTop">↑</button>
</template>
