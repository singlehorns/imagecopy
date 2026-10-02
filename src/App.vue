<script setup>
import { ref } from 'vue'
import { RouterLink } from 'vue-router'
import { company } from './data/company'
import FloatingContacts from './components/FloatingContacts.vue'
const open = ref(false)
const links = [['首頁','/'],['關於印象行','/about'],['專業設備','/equipment'],['服務項目','/services'],['印刷價格','/pricing'],['完稿須知','/artwork-guide'],['檔案傳輸','/file-transfer'],['聯絡我們','/contact']]
</script>
<template>
<header class="site-header"><div class="topbar"><div class="header-wide"><span>印象行 IMAGECOPY｜專業數位影印・印刷・輸出</span><span>服務專線：{{company.phone}}　 Email：{{company.email}}</span></div></div><div class="header-inner"><RouterLink to="/" class="logo" @click="open=false"><img src="/images/branding/since1983.jpg" alt="印象行 Since 1983"></RouterLink><button class="menu" @click="open=!open" :aria-label="open ? '關閉選單' : '開啟選單'"><span v-if="open">×</span><svg v-else class="menu-mark" viewBox="0 0 32 26" aria-hidden="true"><path d="M2 5h28"/><path d="M2 13h28"/><path d="M2 21h14"/></svg></button><nav :class="{show:open}"><button class="menu-close" @click="open=false" aria-label="關閉選單">×</button><RouterLink v-for="l in links.slice(0,-1)" :key="l[1]" :to="l[1]" @click="open=false">{{l[0]}}</RouterLink><a class="mobile-nav-contact" href="https://line.me/" target="_blank" rel="noopener" @click="open=false">聯絡我們</a></nav><a class="header-contact" href="https://line.me/" target="_blank" rel="noopener">聯絡我們 <span>→</span></a></div><div class="notice"><div class="header-wide"><b>服務公告</b><span>印刷、影印、輸出與裝訂服務，歡迎來電或 Email 洽詢。</span><RouterLink to="/file-transfer">檔案傳輸說明 →</RouterLink></div></div></header>
<main><RouterView/></main>
<FloatingContacts />
<footer class="footer"><div class="footer-grid footer-simple"><section class="footer-brand"><RouterLink to="/" class="logo"><img src="/images/branding/since1983.jpg" alt="印象行 Since 1983"></RouterLink></section><section><h4>客服時間</h4><p>營業時間：週一至週六AM9：00-PM21：00、國訂例假日AM10:00~PM18:00<br>每週日公休</p></section><section><h4>取件時間</h4><p>依上班時間為主</p></section><section><h4>聯絡我們</h4><p>電子郵件：<a :href="`mailto:${company.email}`">{{company.email}}</a></p><p>專人報價：<a href="https://line.me/" target="_blank" rel="noopener">點此詢價</a></p><p>聯絡電話：{{company.phone}}</p><p>傳真電話：請來電洽詢</p><p>取件地址：{{company.address}}</p></section><section class="footer-common-links"><h4>常用網站連結</h4><a href="https://web.nutn.edu.tw/" target="_blank" rel="noopener"><img src="/images/branding/nutn-logo.png" alt="國立臺南大學"></a></section></div><div class="copyright">Copyright © IMAGECOPY. All rights reserved.</div></footer>
</template>
