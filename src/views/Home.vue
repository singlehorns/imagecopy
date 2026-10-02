<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { RouterLink } from 'vue-router'
import { services } from '../data/services'
import { equipment } from '../data/equipment'
const serviceTones = { copy: 0, 'large-format': 1, thesis: 2, 'digital-output': 3, 'business-card': 4, poster: 5, scan: 6, binding: 1 }
const equipmentTrack = ref(null)
const carouselEquipment = [...equipment, ...equipment]
let autoplayTimer
let resetTimer
const slideEquipment = (direction = 1) => {
  const el = equipmentTrack.value
  const card = el?.querySelector('.equip-mini')
  if (!el || !card) return
  const gap = Number.parseFloat(getComputedStyle(el).gap) || 0
  const step = card.getBoundingClientRect().width + gap
  const loopPoint = step * equipment.length
  if (direction < 0 && el.scrollLeft <= 1) {
    el.scrollLeft = loopPoint
    requestAnimationFrame(() => el.scrollBy({ left: -step, behavior: 'smooth' }))
    return
  }
  el.scrollBy({ left: direction * step, behavior: 'smooth' })
  if (direction > 0 && el.scrollLeft + step >= loopPoint - 1) {
    clearTimeout(resetTimer)
    resetTimer = window.setTimeout(() => { el.scrollLeft = 0 }, 520)
  }
}
onMounted(() => { autoplayTimer = window.setInterval(() => slideEquipment(1), 4200) })
onBeforeUnmount(() => { clearInterval(autoplayTimer); clearTimeout(resetTimer) })
</script>
<template>
  <section class="hero banner-hero"><picture><source media="(max-width: 800px)" srcset="/images/banner/imagecopy-01-mobile.png"><img class="banner-image" src="/images/banner/inprint-banner.png" alt="印象行數位影印圖文輸出服務 Banner"></picture></section>
  <section class="intro container"><div class="intro-centered"><h2>專業、可靠，<br>陪你完成每一次印製</h2><p>印象行提供影印、印刷、大圖輸出、裝訂及各式文件輸出服務。從一張文件到完整的印刷品，我們重視每個細節，讓交到手上的成果清楚、準確、好使用。</p></div></section>
  <section class="band"><div class="container"><SectionTitle eyebrow="OUR SERVICES" title="需要什麼，我們就從哪裡開始。" description="依照你的文件、尺寸與用途，提供合適的輸出與加工服務。"/><div class="service-grid"><RouterLink v-for="s in services.slice(0,6)" :key="s.slug" :to="'/services/'+s.slug" class="service-card" :class="'tone-'+serviceTones[s.slug]"><span class="service-no">0{{services.indexOf(s)+1}}</span><h3>{{s.title}}</h3><p>{{s.desc}}</p><span class="arrow">↗</span></RouterLink></div><div class="services-more"><span class="services-more-chevron" aria-hidden="true">⌄</span><RouterLink to="/services" class="btn outline">查看全部服務</RouterLink></div></div></section>
  <section class="container equipment-home"><div class="equipment-heading"><h2>專業設備</h2></div><div ref="equipmentTrack" class="equipment-strip equipment-slider"><div v-for="(e,index) in carouselEquipment" :key="`${e[0]}-${index}`" class="equip-mini"><div class="image-placeholder"><img :src="e[2]" :alt="e[0]"></div><p>{{e[0]}}</p></div></div><div class="equipment-slider-controls"><div class="slider-rail"><span></span></div><div class="equipment-arrows"><button class="equipment-arrow" @click="slideEquipment(-1)" aria-label="上一組設備">‹</button><button class="equipment-arrow" @click="slideEquipment(1)" aria-label="下一組設備">›</button></div></div><RouterLink to="/equipment" class="btn outline equipment-link">查看全部設備</RouterLink></section>
  <section class="cta"><div class="container cta-inner"><div><p class="eyebrow">READY TO PRINT?</p><h2>送印前，先把細節確認好。</h2><p>查看價格、完稿與檔案傳輸說明，讓交稿更順利。</p></div><div class="cta-links"><RouterLink to="/pricing">印刷價格 <span>→</span></RouterLink><RouterLink to="/artwork-guide">完稿須知 <span>→</span></RouterLink><RouterLink to="/file-transfer">檔案傳輸 <span>→</span></RouterLink></div></div></section>
  <section class="location-map"><iframe title="印象行 Google 地圖位置" src="https://www.google.com/maps?q=700%20%E8%87%BA%E5%8D%97%E5%B8%82%E4%B8%AD%E8%A5%BF%E5%8D%80%E9%83%A1%E7%8E%8B%E9%87%8C%E6%A8%B9%E6%9E%97%E8%A1%97%E4%BA%8C%E6%AE%B5192%E8%99%9F&output=embed" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe></section>
</template>

<style scoped>
.intro{min-height:0;padding-top:68px;padding-bottom:24px;display:grid;place-items:center;text-align:center}.intro-centered{max-width:760px}.intro-centered .eyebrow{margin-bottom:18px}.intro-centered h2{margin:0 0 20px}.intro-centered>p:not(.eyebrow){margin:0 auto;max-width:680px}.band{padding-top:36px}.service-card.tone-2{--tone:#3b9d9b;--pale:#d9f0ee}.service-card.tone-6{--tone:#a65b92;--pale:#f3dced}.band .service-card{transition:background-color .28s ease,box-shadow .28s ease}.band .service-card:hover{background:var(--pale,#f7f7f4);box-shadow:inset 0 0 0 2px color-mix(in srgb,var(--tone) 78%,#1d2428)}.service-card .service-no,.service-card .arrow{color:var(--tone,var(--orange))}.service-card h3:before{content:'';display:block;width:34px;height:2px;margin:0 0 12px;background:var(--tone,var(--orange))}.service-card:hover .arrow{animation:arrow-emphasis .35s ease both}@keyframes arrow-emphasis{from{opacity:.42;transform:translate(-7px,7px)}to{opacity:1;transform:translate(0,0)}}.band .btn.outline,.equipment-link{background:#fff;transition:background-color .22s ease,border-color .22s ease,box-shadow .22s ease,transform .22s ease}.band .btn.outline:hover,.equipment-link:hover{background:#fff3ec;color:var(--orange);border-color:#c94e26;box-shadow:0 5px 14px #c94e2618;transform:translateY(-2px)}.equipment-home{position:relative;z-index:0;isolation:isolate}.equipment-home::before{content:'';position:absolute;z-index:-1;top:0;left:50%;width:100vw;height:18px;transform:translateX(-50%);background:#f1f1ef;border-top:1px solid #dedfdd;border-bottom:1px solid #dedfdd}.equipment-home::after{content:'';position:absolute;z-index:-1;top:18px;bottom:0;left:calc(50% - 50vw);width:max(28vw,calc((100vw - 1180px)/2 + 300px));background:#eef4f6}.equipment-heading h2{margin:0 0 34px;font-size:26px;font-weight:600;letter-spacing:.04em}.equipment-slider{scrollbar-width:none;padding-bottom:0}.equipment-slider::-webkit-scrollbar{display:none}.equipment-slider-controls{display:flex;align-items:center;gap:28px;margin:22px 0 0}.slider-rail{flex:1;background:#dce2e8}.slider-rail span{width:12%;background:#233a66}.slider-rail span:after{display:none}.equipment-arrows{display:flex;gap:12px}.equipment-arrow{width:45px;height:32px;border:0;border-radius:2px;background:#233a66;color:#fff;font-size:24px;line-height:1;cursor:pointer;padding:0;transition:transform .2s,background .2s}.equipment-arrow:hover{background:#34517f;transform:translateY(-2px)}.equipment-link{display:flex;width:max-content;margin:34px auto 0;padding:10px 25px}.location-map{height:438px;padding-top:58px;background:#eef4f6}.location-map iframe{height:380px}
.service-card .service-no{font-size:16px}
</style>
