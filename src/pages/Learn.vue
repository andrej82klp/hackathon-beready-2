<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="text-center mb-12">
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          Learn First Aid Skills
        </h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto">
          Master essential first aid skills through our carefully designed learning modules. 
          Each module takes 10-15 minutes and earns you a badge when completed.
        </p>
      </div>

      <!-- Progress Overview for Authenticated Users -->
      <div v-if="isAuthenticated && userProgress.length > 0" class="bg-white rounded-xl shadow-lg p-6 mb-8">
        <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">Your Progress</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="text-center">
            <div class="text-3xl font-bold text-teal-800 mb-1">{{ completedCount }}</div>
            <div class="text-sm text-gray-600">Modules Completed</div>
          </div>
          <div class="text-center">
            <div class="text-3xl font-bold text-yellow-600 mb-1">{{ completedCount }}</div>
            <div class="text-sm text-gray-600">Badges Earned</div>
          </div>
          <div class="text-center">
            <div class="text-3xl font-bold text-green-600 mb-1">{{ Math.round(averageScore) }}%</div>
            <div class="text-sm text-gray-600">Average Score</div>
          </div>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="text-center py-12">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-teal-800"></div>
        <p class="mt-4 text-gray-600">Loading modules...</p>
      </div>

      <!-- Modules Grid -->
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div
          v-for="module in modules"
          :key="module.id"
          class="bg-white rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border border-gray-100"
        >
          <div class="p-6">
            <!-- Module Icon and Status -->
            <div class="flex items-center justify-between mb-4">
              <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center">
                <span class="text-2xl">{{ module.icon }}</span>
              </div>
              
              <!-- Progress Status -->
              <div v-if="isAuthenticated" class="text-sm">
                <span
                  v-if="getModuleProgress(module.id)?.completed"
                  class="bg-green-100 text-green-800 px-2 py-1 rounded-full font-medium"
                >
                  ✓ Completed
                </span>
                <span
                  v-else-if="getModuleProgress(module.id)"
                  class="bg-yellow-100 text-yellow-800 px-2 py-1 rounded-full font-medium"
                >
                  In Progress
                </span>
                <span
                  v-else
                  class="bg-gray-100 text-gray-600 px-2 py-1 rounded-full font-medium"
                >
                  Not Started
                </span>
              </div>
            </div>

            <!-- Module Info -->
            <h3 class="text-xl font-heading font-bold text-teal-800 mb-2">
              {{ module.title }}
            </h3>
            <p class="text-gray-600 mb-4">
              {{ module.description }}
            </p>

            <!-- Module Meta -->
            <div class="flex items-center justify-between text-sm text-gray-500 mb-4">
              <span>{{ module.duration }}</span>
              <span class="capitalize">{{ module.difficulty }}</span>
            </div>

            <!-- Score Display for Completed Modules -->
            <div v-if="isAuthenticated && getModuleProgress(module.id)?.completed" class="mb-4">
              <div class="flex items-center justify-between text-sm text-gray-600 mb-1">
                <span>Your Score</span>
                <span class="font-semibold">{{ getModuleProgress(module.id)?.score }}%</span>
              </div>
              <div class="w-full bg-gray-200 rounded-full h-2">
                <div
                  class="bg-green-400 h-2 rounded-full transition-all duration-300"
                  :style="{ width: (getModuleProgress(module.id)?.score || 0) + '%' }"
                ></div>
              </div>
            </div>

            <!-- Action Button -->
            <router-link
              :to="`/learn/${module.id}`"
              @click="handleModuleClick(module.id)"
              class="block w-full bg-teal-800 text-white px-4 py-3 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200 text-center"
            >
              {{ getButtonText(module.id) }}
            </router-link>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-if="!loading && modules.length === 0" class="text-center py-12">
        <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="text-3xl">📚</span>
        </div>
        <h3 class="text-xl font-heading font-bold text-gray-800 mb-2">No Modules Available</h3>
        <p class="text-gray-600">Check back soon for new learning content!</p>
      </div>

      <!-- Call to Action for Non-Authenticated Users -->
      <div v-if="!isAuthenticated" class="mt-12 bg-yellow-50 rounded-2xl border-2 border-yellow-200 p-8 text-center">
        <div class="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="text-3xl">🏆</span>
        </div>
        <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">
          Track Your Progress & Earn Badges
        </h2>
        <p class="text-gray-700 mb-6 max-w-2xl mx-auto">
          Create a free account to track your learning progress, earn achievement badges, 
          and share your accomplishments with friends and family.
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <router-link
            to="/register"
            class="bg-yellow-400 text-teal-800 px-8 py-3 rounded-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
          >
            Create Free Account
          </router-link>
          <router-link
            to="/login"
            class="bg-gray-100 text-gray-700 px-8 py-3 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-200"
          >
            Sign In
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useAuth } from '../stores/auth'
import { useModules } from '../stores/modules'

const { user, isAuthenticated } = useAuth()
const { 
  modules, 
  userProgress, 
  loading, 
  fetchModules, 
  fetchUserProgress, 
  startModule,
  getCompletedModulesCount,
  getAverageScore
} = useModules()

const completedCount = computed(() => getCompletedModulesCount())
const averageScore = computed(() => getAverageScore())

const getModuleProgress = (moduleId: string) => {
  return userProgress.value.find(p => p.module_id === moduleId)
}

const getButtonText = (moduleId: string) => {
  if (!isAuthenticated.value) return 'Start Learning'
  
  const progress = getModuleProgress(moduleId)
  if (progress?.completed) return 'Review Module'
  if (progress) return 'Continue Learning'
  return 'Start Module'
}

const handleModuleClick = async (moduleId: string) => {
  if (isAuthenticated.value && user.value) {
    const progress = getModuleProgress(moduleId)
    if (!progress) {
      // Start tracking this module
      await startModule(user.value.id, moduleId)
    }
  }
}

onMounted(async () => {
  await fetchModules()
  
  if (isAuthenticated.value && user.value) {
    await fetchUserProgress(user.value.id)
  }
})
</script>