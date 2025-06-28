<template>
  <div id="app" class="min-h-screen bg-gray-50">
    <AppHeader />
    <main class="flex-1">
      <router-view />
    </main>
    <AppFooter />
    <CelebratoryModal />
  </div>
</template>

<script setup lang="ts">
import AppHeader from './components/layout/AppHeader.vue'
import AppFooter from './components/layout/AppFooter.vue'
import CelebratoryModal from './components/CelebratoryModal.vue'
</script>