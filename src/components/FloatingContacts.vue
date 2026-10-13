<script setup>
const backToTop = () => window.scrollTo({ top: 0, behavior: window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth' })
</script>
<template>
  <div class="floating-contacts">
    <a class="line-float" href="https://line.me/" target="_blank" rel="noopener noreferrer" aria-label="開啟 LINE 官方網站" title="開啟 LINE">
      <span>LINE</span><span class="contact-tooltip">加 LINE 詢問</span>
    </a>
    <button class="back-top" type="button" aria-label="回到頁首" @click="backToTop"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M6 11l6-6 6 6M12 5v14"/></svg><span>TOP</span></button>
  </div>
</template>
<style scoped>
.back-top{position:relative;overflow:hidden;isolation:isolate;width:58px;height:58px;flex:none;padding:0;border:1px solid #ffffffd9;border-radius:50% 50% 12px 50%;background:conic-gradient(from 35deg at 35% 35%,#f6f5f8,#e4eaf0,#e3f3ef,#faf9ee,#eee5f3,#dfeaf2,#f6f5f8);color:#414955;box-shadow:0 2px 4px #29334520;cursor:pointer;display:flex;flex-direction:column;align-items:center;justify-content:center;gap:2px;transition:box-shadow .25s ease}
.back-top::before{content:'';position:absolute;inset:-30% -80%;z-index:-1;pointer-events:none;background:linear-gradient(115deg,transparent 35%,#ffffffb3 50%,transparent 65%);transform:translateX(-45%);transition:transform .65s ease}
.back-top::after{content:'';position:absolute;right:0;bottom:0;width:13px;height:13px;pointer-events:none;background:linear-gradient(135deg,#d7dbe2,#fff 65%);border-radius:10px 0 0 0;box-shadow:-1px -1px 3px #35404a18}
.back-top:hover::before{transform:translateX(45%)}
.back-top svg{width:22px;height:22px;fill:none;stroke:currentColor;stroke-width:1.6;stroke-linecap:round;stroke-linejoin:round;transition:transform .25s ease}
.back-top span{font:600 10px Arial,sans-serif;letter-spacing:1.5px;line-height:1}
.back-top:hover{box-shadow:0 3px 7px #29334526}
.back-top:hover svg{transform:translateY(-2px)}
.back-top:focus-visible{outline:3px solid #233a66;outline-offset:4px}
@media(max-width:480px){.back-top{width:52px;height:52px;font-size:12px}}
@media(prefers-reduced-motion:reduce){.back-top,.back-top svg,.back-top::before{transition:none}.back-top:hover svg{transform:none}.back-top:hover::before{transform:translateX(-45%)}}
</style>
