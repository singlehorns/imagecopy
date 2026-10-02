<script setup>
import { RouterLink } from 'vue-router'
</script>
<template>
  <section class="about-page container">
    <div class="about-sidebar">
      <div class="about-logo-card"><img src="/images/branding/since1983.jpg" alt="印象行 Since 1983"><p>成立於1983年，創始店址位於建興國中旁，歷經幾次遷徙，現於樹林街二段落腳。</p></div>
      <RouterLink to="/equipment" class="about-side-link">查看專業設備 <span>→</span></RouterLink>
      <a href="https://line.me/" target="_blank" rel="noopener" class="about-side-link">聯絡印象行 <span>→</span></a>
    </div>
    <div class="about-main">
      <p class="about-lead">自1983年印象行創業以來，我們一直秉持著專業、熱忱服務態度的經營理念而努力不懈，憑著豐富的專業知識及融合眾多的市場需求，從傳統粗糙的意識型態，引進全新數位化影印設備及專業分工模式，創造高品質影印專業服務。</p>
      <div class="about-rule">服務、效率、創新、品質</div>
      <div class="about-points">
        <article><span>◎</span><p><b>專業級設備</b>：採用世界知名品牌 HORIZON 專業電腦控制的製冊設備，為您的書冊成品作精緻加工。</p></article>
        <article><span>◎</span><p><b>數位化高品質輸出</b>：引進 RICOH 影印機、Konica Minolta 彩色影印機、Konica Minolta 高階數位高速影印機、Canon Oce 專業輸出設備及各式高階數位化影印設備，大幅提升影印品質。</p></article>
        <article><span>◎</span><p><b>大圖掃描建檔</b>：WideTEK 36CL 德國高階大圖彩色掃描建檔設備，協助紙本資料數位化保存。</p></article>
        <article><span>◎</span><p><b>大圖輸出</b>：採用 HP 高階 8 色輸出印表機，具抗紫外線、抗候防刮原廠墨水，提升大圖輸出品質。</p></article>
        <article><span>◎</span><p><b>品質堅持</b>：堅持使用原裝設備及耗材，確保輸出品質完美。</p></article>
      </div>
    </div>
  </section>
</template>

<style scoped>
.about-side-link span{transition:transform .25s ease,color .25s ease}.about-side-link:hover span{color:#c94e26;transform:translateX(7px)}
</style>
