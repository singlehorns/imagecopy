<script setup>
defineProps({
  type: { type: String, required: true },
  label: { type: String, required: true }
})
</script>

<template>
  <svg class="service-category-icon" viewBox="0 0 64 64" fill="none" stroke="currentColor" stroke-width="2.6" stroke-linecap="round" stroke-linejoin="round" role="img" :aria-label="label">
    <template v-if="type === 'copy'">
      <path d="M19 24V11h26v13"/><path d="M17 49H12V28a7 7 0 0 1 7-7h26a7 7 0 0 1 7 7v21h-5"/><rect x="17" y="38" width="30" height="15" rx="2"/><path d="M22 43h20M22 48h14"/><path d="M45 29h1"/>
    </template>
    <template v-else-if="type === 'large-format'">
      <path d="M10 20h44v20H10z"/><path d="M15 20v-7h34v7M16 40v8M48 40v8"/><path d="M17 48h30"/><path d="M18 28h28"/><path d="M23 40v12h18V40"/><path d="M51 27h1"/>
    </template>
    <template v-else-if="type === 'thesis'">
      <path d="M17 11h26a5 5 0 0 1 5 5v36H22a5 5 0 0 0-5 5V16a5 5 0 0 1 5-5Z"/><path d="M22 20h20M22 27h20M22 34h14"/><path d="M17 52h27"/>
    </template>
    <template v-else-if="type === 'digital-output'">
      <rect x="12" y="12" width="40" height="31" rx="3"/><path d="M21 52h22M32 43v9"/><path d="M20 20h24v15H20z"/><path d="m24 31 6-6 5 5 3-3 3 4"/>
    </template>
    <template v-else-if="type === 'business-card'">
      <rect x="13" y="18" width="35" height="24" rx="3" transform="rotate(-7 13 18)"/><rect x="18" y="23" width="35" height="24" rx="3"/><path d="M24 31h12M24 37h20"/>
    </template>
    <template v-else-if="type === 'poster'">
      <path d="M15 53 28 13h8l13 40"/><path d="M21 39h22"/><path d="M25 25h14v14H25z"/><path d="m27 35 4-4 3 3 2-2 2 3"/>
    </template>
    <template v-else>
      <path d="M12 22h40v24H12z"/><path d="M18 22v-7h28v7"/><path d="M18 40h28"/><path d="m24 31 5-5 5 4 5-5"/><path d="M20 48h24"/>
    </template>
  </svg>
</template>

<style scoped>
.service-category-icon { width: 42px; height: 42px; display: block; }
</style>
