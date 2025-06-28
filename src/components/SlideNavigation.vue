<template>
  <div class="slide-navigation-container">
    <!-- Slide Content -->
    <div class="slide-content-wrapper">
      <div class="slide-header mb-6">
        <div class="flex items-center justify-between mb-4">
          <div class="text-sm text-gray-500">
            {{ currentSlideIndex + 1 }} of {{ slides.length }}
          </div>
        </div>
        
        <!-- Progress Bar -->
        <div class="w-full bg-gray-200 rounded-full h-2 mb-6">
          <div
            class="bg-yellow-400 h-2 rounded-full transition-all duration-300"
            :style="{ width: ((currentSlideIndex + 1) / slides.length) * 100 + '%' }"
          ></div>
        </div>
      </div>

      <!-- Current Slide -->
      <div class="slide-content min-h-[400px] md:min-h-[500px]">
        <div v-if="currentSlide" v-html="currentSlide.content"></div>
      </div>
    </div>

    <!-- Navigation Controls -->
    <div class="slide-navigation mt-8">
      <div class="flex items-center justify-between">
        <!-- Previous Button -->
        <button
          @click="previousSlide"
          :disabled="currentSlideIndex === 0"
          class="flex items-center px-6 py-3 bg-gray-100 text-gray-700 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
          </svg>
          Previous
        </button>

        <!-- Slide Indicators -->
        <div class="hidden md:flex items-center space-x-2">
          <button
            v-for="(slide, index) in slides"
            :key="index"
            @click="goToSlide(index)"
            class="w-3 h-3 rounded-full transition-colors duration-200"
            :class="index === currentSlideIndex ? 'bg-yellow-400' : 'bg-gray-300 hover:bg-gray-400'"
          ></button>
        </div>

        <!-- Next Button -->
        <button
          @click="nextSlide"
          :disabled="currentSlideIndex === slides.length - 1"
          class="flex items-center px-6 py-3 bg-teal-800 text-white rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Next
          <svg class="w-5 h-5 ml-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
          </svg>
        </button>
      </div>

      <!-- Mobile Slide Indicators -->
      <div class="md:hidden flex justify-center mt-4">
        <div class="flex items-center space-x-2">
          <button
            v-for="(slide, index) in slides"
            :key="index"
            @click="goToSlide(index)"
            class="w-2 h-2 rounded-full transition-colors duration-200"
            :class="index === currentSlideIndex ? 'bg-yellow-400' : 'bg-gray-300'"
          ></button>
        </div>
      </div>
    </div>

    <!-- Test Link (shown on last slide) -->
    <div v-if="currentSlideIndex === slides.length - 1" class="mt-8 text-center">
      <div class="bg-yellow-50 border-2 border-yellow-200 rounded-xl p-6">
        <!-- Authenticated Users -->
        <div v-if="isAuthenticated">
          <h3 class="text-xl font-heading font-bold text-teal-800 mb-4">
            🏆 Ready for Your Badge?
          </h3>
          <p class="text-gray-700 mb-6">
            You've completed all the slides! Now test your knowledge to earn your 
            <strong>{{ module?.badge_name }}</strong> badge.
          </p>
          <button
            @click="startTest"
            class="bg-yellow-400 text-teal-800 px-8 py-4 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200 shadow-lg"
          >
            Take the Test to Earn Your Badge
          </button>
        </div>
        
        <!-- Non-authenticated Users -->
        <div v-else>
          <h3 class="text-xl font-heading font-bold text-teal-800 mb-4">
            🔐 Sign In to Earn Your Badge
          </h3>
          <p class="text-gray-700 mb-6">
            You've completed all the slides! To test your knowledge and earn your 
            <strong>{{ module?.badge_name }}</strong> badge, please sign in to your account.
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <router-link
              to="/login"
              class="bg-teal-800 text-white px-8 py-4 rounded-lg text-lg font-bold hover:bg-teal-700 transition-colors duration-200"
            >
              Sign In
            </router-link>
            <router-link
              to="/register"
              class="bg-yellow-400 text-teal-800 px-8 py-4 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
            >
              Create Account
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useAuth } from '../stores/auth'

interface Slide {
  id: number
  title: string
  content: string
}

interface Module {
  id: string
  title: string
  badge_name: string
}

interface Props {
  slides: Slide[]
  module: Module | null
}

const props = defineProps<Props>()
const emit = defineEmits(['start-test'])
const { isAuthenticated } = useAuth()

const currentSlideIndex = ref(0)

const currentSlide = computed(() => {
  return props.slides[currentSlideIndex.value] || null
})

const nextSlide = () => {
  if (currentSlideIndex.value < props.slides.length - 1) {
    currentSlideIndex.value++
  }
}

const previousSlide = () => {
  if (currentSlideIndex.value > 0) {
    currentSlideIndex.value--
  }
}

const goToSlide = (index: number) => {
  if (index >= 0 && index < props.slides.length) {
    currentSlideIndex.value = index
  }
}

const startTest = () => {
  emit('start-test')
}

// Keyboard navigation
const handleKeydown = (event: KeyboardEvent) => {
  if (event.key === 'ArrowLeft') {
    previousSlide()
  } else if (event.key === 'ArrowRight') {
    nextSlide()
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleKeydown)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleKeydown)
})
</script>

<style scoped>
.slide-content-wrapper {
  @apply bg-white rounded-xl shadow-lg p-6 md:p-8;
}

.slide-content :deep(h2) {
  @apply text-2xl md:text-3xl font-heading font-bold text-teal-800 mb-6;
}

.slide-content :deep(h3) {
  @apply text-lg md:text-xl font-heading font-bold text-teal-800 mb-3;
}

.slide-content :deep(h4) {
  @apply text-base md:text-lg font-semibold text-gray-800 mb-2;
}

.slide-content :deep(p) {
  @apply text-gray-700 leading-relaxed mb-4;
}

.slide-content :deep(ul) {
  @apply text-gray-700 mb-4;
}

.slide-content :deep(li) {
  @apply mb-2;
}

.slide-content :deep(.grid) {
  @apply gap-4 md:gap-6;
}

/* Responsive adjustments */
@media (max-width: 768px) {
  .slide-content :deep(.grid-cols-2) {
    @apply grid-cols-1;
  }
  
  .slide-content :deep(.md\\:grid-cols-2) {
    @apply grid-cols-1;
  }
}
</style>