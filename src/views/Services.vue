<script setup>
import ServiceCategoryIcon from '../components/ServiceCategoryIcon.vue'
const principles = [
  ['專業級設備', '採用世界知名品牌 HORIZON 專業電腦控制的製冊設備，為您的書冊成品作精緻加工。'],
  ['數位化高品質輸出', '引進 RICOH 影印機、Konica Minolta 彩色影印機、Konica Minolta 高階數位高速影印機、Canon Oce 專業輸出設備及各式高階數位化影印設備，大幅提升影印品質。'],
  ['大圖掃描建檔', 'WideTEK 36CL 德國高階大圖彩色掃描建檔設備，協助紙本資料數位化保存。'],
  ['大圖輸出', '採用 HP 高階 8 色輸出印表機，具抗紫外線、抗候防刮原廠墨水，提升大圖輸出品質。'],
  ['品質堅持', '堅持使用原裝設備及耗材，確保輸出品質完美。']
]
const serviceItems = [
  { title: '影印、彩色影印', desc: '提供文件與圖文資料的黑白、彩色影印服務。', icon: 'copy' },
  { title: '裝訂、大圖輸出', desc: '從文件裝訂到大尺寸輸出，依成品需求安排製作。', icon: 'large-format' },
  { title: '論文學術研究報告', desc: '協助研究報告、論文文件的輸出與裝訂。', icon: 'thesis' },
  { title: '電腦檔案圖文輸出', desc: '將電腦檔案轉換為清晰、穩定的圖文輸出。', icon: 'digital-output' },
  { title: '名片、海報、型錄', desc: '提供名片、海報與型錄等印刷品製作。', icon: 'business-card' },
  { title: '大型海報、設計製作', desc: '支援大型海報輸出與設計製作需求。', icon: 'poster' },
  { title: '大型海報、掃瞄建檔', desc: '提供大型圖稿掃描與數位建檔服務。', icon: 'scan' }
]
</script>
<template>
  <section class="container services-page">
    <section class="service-principles" aria-labelledby="principles-title"><h2 id="principles-title">專業、服務、效率、創新、品質</h2><div class="principle-list"><article v-for="principle in principles" :key="principle[0]"><h3>{{principle[0]}}</h3><p>{{principle[1]}}</p></article></div></section>
    <section class="service-list" aria-labelledby="service-list-title"><div class="service-list-heading"><h2 id="service-list-title">我們提供的服務</h2></div><div class="service-detail-grid"><article v-for="(item,index) in serviceItems" :key="item.title" class="service-feature" :class="'tone-'+(index%8)"><span class="feature-icon"><ServiceCategoryIcon :type="item.icon" :label="item.title" /></span><div><h3>{{item.title}}</h3><p>{{item.desc}}</p></div></article></div></section>
  </section>
</template>
<style scoped>
.service-principles { margin: 4px 0 52px; padding: 0; background: transparent; color: #1d2428; border-left: 0; }
.service-principles h2 { margin: 0 0 14px; font-size: 30px; color: #1d2428; }
.service-principles .principle-list { display: grid; gap: 0; margin: 0; }
.service-principles .principle-list article { display: grid; grid-template-columns: 190px 1fr; gap: 22px; padding: 14px 0; border: 0; border-top: 1px solid #dfe3e2; }
.service-principles .principle-list article:last-child { padding-bottom: 0; border-bottom: 0; }
.service-principles .principle-list h3 { margin: 0; color: #1d2428; font-size: 18px; }
.service-principles .principle-list h3::before { content: '◎ '; color: #d51f26; }
.service-principles .principle-list p { max-width: none; margin: 0; color: #697278; line-height: 1.9; }
.tone-2 { --tone: #3b9d9b; --pale: #d9f0ee; }
.tone-6 { --tone: #a65b92; --pale: #f3dced; }
@media(max-width:700px) { .service-principles .principle-list article { grid-template-columns: 1fr; gap: 6px; } }
</style>
