<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Loading State -->
      <div v-if="loading" class="text-center py-12">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-teal-800"></div>
        <p class="mt-4 text-gray-600">Loading module...</p>
      </div>

      <!-- Module Not Found -->
      <div v-else-if="!module" class="text-center py-12">
        <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="text-3xl">❓</span>
        </div>
        <h1 class="text-2xl font-heading font-bold text-gray-800 mb-4">Module Not Found</h1>
        <p class="text-gray-600 mb-6">The module you're looking for doesn't exist.</p>
        <router-link
          to="/learn"
          class="bg-teal-800 text-white px-6 py-3 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200"
        >
          Back to Modules
        </router-link>
      </div>

      <!-- Module Content -->
      <div v-else>
        <!-- Module Header -->
        <div class="bg-white rounded-xl shadow-lg p-6 md:p-8 mb-8">
          <div class="flex items-center mb-6">
            <router-link
              to="/learn"
              class="mr-4 text-gray-500 hover:text-teal-800 transition-colors duration-200"
            >
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
              </svg>
            </router-link>
            <div class="flex-1">
              <div class="flex items-center space-x-4 mb-2">
                <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
                  <span class="text-2xl">{{ module.icon }}</span>
                </div>
                <div>
                  <h1 class="text-2xl md:text-3xl font-heading font-bold text-teal-800">
                    {{ module.title }}
                  </h1>
                  <div class="flex items-center space-x-4 text-sm text-gray-500">
                    <span>{{ module.duration }}</span>
                    <span class="capitalize">{{ module.difficulty }}</span>
                    <span v-if="moduleProgress?.completed" class="text-green-600 font-medium">
                      ✓ Completed ({{ moduleProgress.score }}%)
                    </span>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <p class="text-lg text-gray-600">
            {{ module.description }}
          </p>
        </div>

        <!-- Slide-based Content or Regular Content -->
        <div v-if="moduleSlides?.slides">
          <SlideNavigation
            :module="module"
            :slides="moduleSlides.slides"
            @start-test="startTest"
          />
        </div>

        <!-- Test Modal -->
        <div
          v-if="showTest"
          class="fixed inset-0 z-50 overflow-y-auto bg-black bg-opacity-50 flex items-center justify-center p-4"
        >
          <div class="bg-white rounded-xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
            <div class="p-6 md:p-8">
              <ModuleTest
                v-if="module"
                :module-id="module.id"
                :module-name="module.title"
                :badge-name="module.badge_name"
                @test-completed="handleTestCompleted"
                @close="closeTest"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useAuth } from '../stores/auth'
import { useModules } from '../stores/modules'
import { useAchievements } from '../stores/achievements'
import SlideNavigation from '../components/SlideNavigation.vue'
import ModuleTest from '../components/ModuleTest.vue'
import type { Module } from '../lib/supabase'

const route = useRoute()
const { user, isAuthenticated } = useAuth()
const { fetchModuleById, startModule, completeModule, fetchUserProgress, userProgress } = useModules()
const { earnBadge } = useAchievements()

const module = ref<Module | null>(null)
const loading = ref(true)
const showTest = ref(false)
const currentQuestion = ref(0)
const moduleSlides = ref<{ slides?: any[] } | null>(null)
const selectedAnswer.ref(0)
const userAnswers.ref([])
const testScore.ref(0)

const moduleProgress = computed(() => {
  if (!user.value || !module.value) return null
  return userProgress.value.find(p => p.module_id === module.value!.id)
})


onMounted(async () => {
  const moduleId = route.params.id as string
  
  try {
    const { data, error } = await fetchModuleById(moduleId)
    if (error) throw error
    module.value = data
    
    // Parse module content to extract slides
    if (data?.content) {
      try {
        moduleSlides.value = JSON.parse(data.content)
      } catch (parseError) {
        console.error('Error parsing module content:', parseError)
        moduleSlides.value = null
      }
    }
    
    // Start tracking this module if user is authenticated
    if (isAuthenticated.value && user.value) {
      await fetchUserProgress(user.value.id)
      await startModule(user.value.id, moduleId)
    }
  } catch (error) {
    console.error('Error loading module:', error)
  } finally {
    loading.value = false
  }
})

const startTest = () => {
  showTest.value = true
  currentQuestion.value = 0
  selectedAnswer.value = null
  userAnswers.value = []
  testScore.value = 0
}

const closeTest = () => {
  showTest.value = false
}

const handleTestCompleted = async (score: number, moduleId: string) => {
  if (!isAuthenticated.value || !user.value || !module.value) {
    console.warn('User not authenticated or module not loaded')
    return
  }

  try {
    // Complete the module with the score
    await completeModule(user.value.id, moduleId, score)
    
    // Award badge if passing score (70% or higher)
    if (score >= 70) {
      await earnBadge(user.value.id, module.value.badge_name, module.value.id)
    }
    
    console.log(`Module completed with score: ${score}%`)
  } catch (error) {
    console.error('Error saving test completion:', error)
  }
}
</script>