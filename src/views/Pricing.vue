<script setup>
import { computed, ref, watch } from 'vue'
import { pricing } from '../data/pricing'
const categories = ['合版名片','貼紙','合版海報－銅版紙','合版海報－雪銅紙','合版海報－模造紙／道林紙','大型海報']
const quickCategory = ref(0)
const selectCategory = index => { quickCategory.value = index }
const normalizedRows = (p) => {
  if (p.title === '貼紙') return p.rows.map(row => {
    const names = {
      '局部貼紙': '局部貼紙\n(高黏貼紙+霧膜+局部上光+背刀)',
      '上霧貼紙': '上霧貼紙\n(高黏貼紙+霧膜+背刀)',
      '透明貼紙＋白墨（上亮膜）': '透明貼紙+白墨\n(上亮膜)',
      '透明貼紙（上亮膜）': '透明貼紙\n(上亮膜)',
      '高黏度貼紙': '高黏度貼紙\n(上亮膜+背刀)',
      '超黏度貼紙': '超黏度貼紙\n(上亮膜+背刀)',
      '合成（珠光）貼紙': '合成(珠光)貼紙',
      '模造貼紙': '模造貼紙',
      '赤牛皮貼紙': '赤牛皮貼紙',
      '靜電貼紙（不含白墨）': '靜電貼紙\n(不含白墨)',
      '銀箔貼紙': '銀箔貼紙'
    }
    return [names[row[0]] ?? row[0], row[1], row[2]]
  })
  if (p.title !== '合版彩色名片') return p.rows
  const rows = p.rows.map(original => {
    const row = [...original]
    row[1] = row[1].replace(/盒$/, '')
    if (row[0] === '一般卡') return ['一級卡', ...row.slice(1)]
    if (row[0] === '珠光紙／單面亮／單面霧（單霧膜）') return ['珠光紙\n單面亮、單面霧\n單霧局(單面上霧+單面局部上光)', ...row.slice(1)]
    if (row[0] === '合成卡／萊妮卡／安格卡／象牙卡／雙面霧膜') return ['合成卡、萊妮卡\n安格卡、象牙卡\n雙面亮膜、雙面霧膜', row[1], row[2], row[3]]
    if (row[0] === '星幻紙／雅紋紙／印尼雲彩／炫光紙（雙霧膜）') return ['星幻紙／雅紋紙／印尼雲彩／炫光紙\n雙霧局（雙面霧＋單面局部上光）', row[1], row[2], row[3]]
    if (row[0] === '永采紙／蒂紋紙／珠典一級卡') return ['永采紙、帝紋紙\n瑞典一級卡\n頂級象牙、頂級雙面霧+雙面局部上光', row[1], row[2], row[3]]
    if (row[0] === '霧透卡（只可單面印刷）' || row[0] === '全透卡（只可單面印刷，最低數量5盒）') return ['霧透卡（只可單面印刷）\n全透卡（只可單面印刷）最低數量5盒', row[1], row[2], row[3]]
    if (row[0] === '水彩紙／彩幻紙／儷紋紙／棉絮紙／雙色菜妮／砂點紙') return ['水彩紙／彩幻紙\n儷紋紙\n棉絮紙\n雙色萊妮／砂點紙', row[1], row[2], row[3]]
    if (['細波紙／爵士卡／細紋紙','絲絨卡（雙面印刷限定）','磨砂卡（雙面印刷限定）'].includes(row[0])) return ['細波紙／爵士卡／細紋紙\n絲絨卡（雙面印刷限定）\n磨砂卡（雙面印刷限定）', row[1], row[2], row[3]]
    if (row[0] === '琥珀紙／金屬紙／奇幻紙') return ['琥珀紙／金陽紙／奇幻紙', row[1], row[2], row[3]]
    if (row[0] === '金楓紙／金箔紙') return ['金碧紙／金綺紙', row[1], row[2], row[3]]
    return row
  })
  return rows.map(([name, ...values]) => [name.replaceAll('／', '、'), ...values])
}
const visiblePricing = computed(() => pricing.map((p, index) => ({
  ...p,
  columns: p.title === '貼紙' ? ['貼紙種類', '盒數', '單面印刷'] : p.columns,
  index,
  rows: normalizedRows(p)
})).filter(p => p.index === quickCategory.value))
const quickItem = ref('')
const quickQuantity = ref('')
const quickRows = computed(() => normalizedRows(pricing[quickCategory.value]))
const quickItems = computed(() => [...new Set(quickRows.value.map(row => row[0]))])
const quickQuantities = computed(() => quickRows.value.filter(row => row[0] === quickItem.value))
const quickResult = computed(() => quickQuantities.value.find(row => row[1] === quickQuantity.value))
const quickSide = ref(2)
watch(quickItems, items => { quickItem.value = items[0] || '' }, { immediate: true })
watch(quickQuantities, rows => { quickQuantity.value = rows[0]?.[1] || ''; quickSide.value = 2 }, { immediate: true })
const formatPrice = value => /^\d+$/.test(value) ? `NT$ ${Number(value).toLocaleString('en-US')}` : value === '—' ? '不提供雙面印刷' : value
const groupedRows = (rows) => rows.reduce((groups, row) => {
  const last = groups[groups.length - 1]
  if (last && last[0][0] === row[0]) last.push(row)
  else groups.push([row])
  return groups
}, [])
</script>
<template>
  <section class="pricing-page container">
    <div class="pricing-layout">
      <main class="pricing-main">
        <section id="quick-price" class="quick-price" aria-label="快速查價">
          <h2>{{categories[quickCategory]}}</h2>
          <div class="spec-row"><label class="spec-label" for="quick-stock">紙張種類：</label><div class="stock-field"><select id="quick-stock" v-model="quickItem"><option v-for="item in quickItems" :key="item" :value="item">{{item.replaceAll('\n', ' / ')}}</option></select><p class="stock-details">{{quickItem}}</p></div></div>
          <div class="spec-row"><span class="spec-label">單／雙列印：</span><div class="spec-options"><button type="button" :class="{chosen: quickSide === 2}" :aria-pressed="quickSide === 2" @click="quickSide = 2">單面</button><button v-if="quickResult?.[3] && quickResult[3] !== '—'" type="button" :class="{chosen: quickSide === 3}" :aria-pressed="quickSide === 3" @click="quickSide = 3">雙面</button></div></div>
          <div class="spec-row"><span class="spec-label">訂購數量：</span><div class="spec-options"><button v-for="row in quickQuantities" :key="row[1]" type="button" :class="{chosen: quickQuantity === row[1]}" :aria-pressed="quickQuantity === row[1]" @click="quickQuantity = row[1]">{{row[1]}}{{quickCategory < 2 ? '盒' : '張'}}</button></div></div>
          <div class="spec-row price-total" aria-live="polite"><span class="spec-label">價格總計：</span><div v-if="quickResult"><strong>{{formatPrice(quickResult[quickSide])}}</strong><span class="price-unit"> 元</span></div></div>
          <div class="quote-actions"><a href="https://line.me/" target="_blank" rel="noopener">聯絡詢價</a><a href="/file-transfer">檔案傳輸 →</a></div>
        </section>
        <section v-for="p in visiblePricing" :key="p.title" :id="'price-'+p.index" class="price-section"><h2>{{p.title === '貼紙' ? '貼紙種類' : p.title}}</h2><div class="table-scroll"><table><thead><tr><th v-for="c in p.columns" :key="c">{{c}}</th></tr></thead><tbody><template v-for="group in groupedRows(p.rows)" :key="group[0][0]"><tr v-for="(row,rowIndex) in group" :key="row.join('')"><td v-if="rowIndex === 0" :rowspan="group.length" class="group-label">{{row[0]}}</td><td v-for="(cell,cellIndex) in row.slice(1)" :key="cellIndex">{{cell}}</td></tr></template></tbody></table></div><div v-if="p.notes" class="pricing-notes"><p v-for="note in p.notes" :key="note">{{note}}</p></div></section>
      </main>
      <aside class="pricing-sidebar"><h2>各類印刷價格</h2><button v-for="(c,i) in categories" :key="c" type="button" :class="{active: quickCategory === i}" :aria-pressed="quickCategory === i" @click="selectCategory(i)">{{c}}</button></aside>
    </div>
  </section>
</template>
<style scoped>
.pricing-main { min-width: 0; }
.pricing-sidebar button { display: block; width: 100%; padding: 22px 15px; border: 0; border-bottom: 1px solid #fff; background: #fff3bb; color: #2b3195; font: inherit; font-weight: 700; text-align: center; cursor: pointer; }
.pricing-sidebar button:hover { background: #f7e69d; }
.pricing-sidebar button.active { background: #d63f88; color: #111; }
.pricing-sidebar button:focus-visible { outline: 2px solid #765bc5; outline-offset: -3px; }
@media(max-width:800px) { .pricing-sidebar button { padding: 13px 8px; font-size: 13px; } }
.price-heading { display: flex; align-items: center; gap: 24px; flex-wrap: wrap; margin-bottom: 10px; }
.price-heading h1 { margin: 0; }
.quick-toggle { display: inline-flex; align-items: center; gap: 22px; padding: 12px 18px; background: #17212b; color: white; border: 0; border-radius: 4px; font: inherit; cursor: pointer; }
.quick-toggle:hover { background: #d51f26; }
.quick-toggle:focus-visible { outline: 3px solid #e85d2a; outline-offset: 3px; }
.quick-price { padding: 14px 0 28px; margin-bottom: 24px; background: #fff; color: #444; }
.spec-row { display: grid; grid-template-columns: 112px minmax(0,1fr); gap: 18px; align-items: start; padding: 15px 0; }
.spec-label { margin: 0; text-align: right; font-size: 16px; font-weight: 400; line-height: 34px; }
.spec-options { display: flex; flex-wrap: wrap; gap: 10px; }
.spec-options button { position: relative; padding: 4px 22px; min-height: 34px; border: 1px solid #ccc; border-radius: 2px; background: white; color: #555; font: inherit; line-height: 24px; cursor: pointer; }
.spec-options button:hover { border-color: #765bc5; color: #765bc5; }
.spec-options button.chosen { border-color: #342a50; background: #342a50; color: #fff; font-weight: 700; }
.spec-options button.chosen:hover { border-color: #342a50; background: #342a50; color: #fff; }
.stock-field { min-width: 0; }
.stock-field select { width: 100%; padding: 6px 10px; border: 1px solid #ccc; background: white; color: #444; font: inherit; border-radius: 2px; }
.stock-details { white-space: pre-line; margin: 8px 0 0; color: #777; font-size: 13px; }
.price-total { border-top: 1px solid #eee; margin-top: 18px; padding-top: 24px; align-items: center; }
.price-total strong { color: #765bc5; font: 700 34px/1.3 Arial,sans-serif; }
.price-unit { color: #765bc5; }
.quote-actions { display: flex; gap: 8px; margin-top: 10px; }
.quote-actions a { padding: 12px 32px; border: 1px solid #765bc5; border-radius: 2px; color: #765bc5; font-size: 18px; }
.quote-actions a:first-child { background: #765bc5; color: white; }
.quick-price :focus-visible { outline: 2px solid #765bc5; outline-offset: 3px; }
@media(max-width:600px) { .spec-row { grid-template-columns: 88px minmax(0,1fr); gap: 10px; } .spec-label { font-size: 14px; } .spec-options button { padding: 4px 16px; font-size: 14px; } .quote-actions a { padding: 10px 20px; } }
.quick-price h2 { margin: 0 0 16px; font-size: 20px; }
.quick-fields { display: grid; grid-template-columns: 1fr 2fr 1fr; gap: 16px; }
.quick-fields label { margin: 0; min-width: 0; }
.quick-fields select { display: block; width: 100%; min-width: 0; margin-top: 8px; height: 44px; padding: 0 10px; font: inherit; background: white; color: #17212b; border: 1px solid #cbd1d5; border-radius: 4px; }
.quick-fields select:disabled { opacity: .5; }
.quick-result { margin-top: 22px; border-top: 1px solid #dfe3e2; padding-top: 18px; }
.quick-result p { margin: 0; }
.quick-name { white-space: pre-line; }
.quick-prices { display: flex; gap: 36px; flex-wrap: wrap; margin-top: 16px; }
.quick-prices span { display: block; font-size: 13px; color: #697278; }
.quick-prices strong { font-size: 24px; color: #d51f26; }
@media(max-width:700px) { .quick-fields { grid-template-columns: 1fr; } .quick-price { padding: 18px; } }
.price-section table { table-layout: fixed; width: 100%; }
.price-section th:first-child { width: 44%; }
.price-section th:nth-child(2) { width: 16%; }
.price-section table tbody tr td { text-align: center; vertical-align: middle; font-weight: 400; font-variant-numeric: tabular-nums; }
.price-section table tbody tr td.group-label { white-space: pre-line; line-height: 1.9; padding: 20px 12px; overflow-wrap: anywhere; }
</style>
