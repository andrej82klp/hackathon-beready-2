<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Welcome Header -->
      <div class="mb-8">
        <h1 class="text-3xl md:text-4xl font-heading font-bold text-teal-800">
          Welcome back, {{ user?.email?.split('@')[0] }}!
        </h1>
        <p class="text-lg text-gray-600 mt-2">
          Continue building your first aid skills and earning badges.
        </p>
      </div>

      <!-- Stats Overview -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="bg-white rounded-xl shadow-lg p-6 text-center">
          <div class="w-12 h-12 bg-teal-100 rounded-full flex items-center justify-center mx-auto mb-3">
            <span class="text-teal-800 text-2xl">📚</span>
          </div>
          <div class="text-3xl font-bold text-teal-800 mb-1">{{ completedCount }}</div>
          <div class="text-sm text-gray-600">Modules Completed</div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 text-center">
          <div class="w-12 h-12 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-3">
            <span class="text-yellow-600 text-2xl">🏅</span>
          </div>
          <div class="text-3xl font-bold text-yellow-600 mb-1">{{ userAchievements.length }}</div>
          <div class="text-sm text-gray-600">Badges Earned</div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 text-center">
          <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-3">
            <span class="text-green-600 text-2xl">🔥</span>
          </div>
          <div class="text-3xl font-bold text-green-600 mb-1">{{ currentStreak }}</div>
          <div class="text-sm text-gray-600">Day Streak</div>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-6 text-center">
          <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mx-auto mb-3">
            <span class="text-purple-600 text-2xl">📊</span>
          </div>
          <div class="text-3xl font-bold text-purple-600 mb-1">{{ Math.round(averageScore) }}%</div>
          <div class="text-sm text-gray-600">Average Score</div>
        </div>
      </div>

      <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- Recent Activity -->
        <div class="lg:col-span-2">
          <div class="bg-white rounded-xl shadow-lg p-6 mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-6">Continue Learning</h2>
            
            <div v-if="loading" class="text-center py-8">
              <div class="inline-block animate-spin rounded-full h-6 w-6 border-b-2 border-teal-800"></div>
              <p class="mt-2 text-gray-600">Loading modules...</p>
            </div>

            <div v-else-if="suggestedModules.length > 0" class="space-y-4">
              <div
                v-for="module in suggestedModules"
                :key="module.id"
                class="flex items-center p-4 border border-gray-200 rounded-lg hover:border-teal-200 hover:shadow-md transition-all duration-200"
              >
                <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mr-4">
                  <span class="text-2xl">{{ module.icon }}</span>
                </div>
                
                <div class="flex-1">
                  <h3 class="font-semibold text-gray-800">{{ module.title }}</h3>
                  <p class="text-sm text-gray-600">{{ module.description }}</p>
                  <div class="flex items-center mt-2 space-x-4 text-xs text-gray-500">
                    <span>{{ module.duration }}</span>
                    <span class="capitalize">{{ module.difficulty }}</span>
                    <span v-if="getModuleProgress(module.id)?.completed" class="text-green-600 font-medium">
                      ✓ Completed
                    </span>
                    <span v-else-if="getModuleProgress(module.id)" class="text-yellow-600 font-medium">
                      In Progress
                    </span>
                  </div>
                </div>

                <div class="text-right">
                  <router-link
                    :to="`/learn/${module.id}`"
                    class="bg-teal-800 text-white px-4 py-2 rounded-lg font-medium hover:bg-teal-700 transition-colors duration-200"
                  >
                    {{ getModuleProgress(module.id)?.completed ? 'Review' : getModuleProgress(module.id) ? 'Continue' : 'Start' }}
                  </router-link>
                </div>
              </div>
            </div>

            <div v-else class="text-center py-8">
              <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="text-3xl">🎉</span>
              </div>
              <h3 class="text-lg font-heading font-bold text-gray-800 mb-2">All Caught Up!</h3>
              <p class="text-gray-600">You've completed all available modules. Check back for new content!</p>
            </div>

            <div class="mt-6 text-center">
              <router-link
                to="/learn"
                class="inline-block bg-gray-100 text-teal-800 px-6 py-3 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-200"
              >
                View All Modules
              </router-link>
            </div>
          </div>

          <!-- Recent Achievements -->
          <div class="bg-white rounded-xl shadow-lg p-6">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-6">Recent Achievements</h2>
            
            <div v-if="recentAchievements.length > 0" class="space-y-4">
              <div
                v-for="achievement in recentAchievements"
                :key="achievement.id"
                class="flex items-center p-4 bg-yellow-50 border border-yellow-200 rounded-lg"
              >
                <div class="w-12 h-12 bg-yellow-400 rounded-full flex items-center justify-center mr-4">
                  <span class="text-2xl">🏅</span>
                </div>
                
                <div class="flex-1">
                  <h3 class="font-semibold text-teal-800">{{ achievement.badge_name }}</h3>
                  <p class="text-sm text-gray-600">
                    Earned {{ formatDate(achievement.earned_at) }}
                  </p>
                </div>

                <button
                  @click="shareAchievement('facebook', achievement.badge_name)"
                  class="bg-yellow-400 text-teal-800 px-3 py-1 rounded text-sm font-medium hover:bg-yellow-300 transition-colors duration-200"
                >
                  Share
                </button>
              </div>
            </div>

            <div v-else class="text-center py-8">
              <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="text-3xl">🏆</span>
              </div>
              <p class="text-gray-600">No achievements yet. Complete your first module to earn a badge!</p>
            </div>

            <div class="mt-6 text-center">
              <router-link
                to="/achievements"
                class="inline-block bg-yellow-400 text-teal-800 px-6 py-3 rounded-lg font-semibold hover:bg-yellow-300 transition-colors duration-200"
              >
                View All Badges
              </router-link>
            </div>
          </div>
        </div>

        <!-- Sidebar -->
        <div>
          <!-- Quick Actions -->
          <div class="bg-white rounded-xl shadow-lg p-6 mb-6">
            <h3 class="text-lg font-heading font-bold text-teal-800 mb-4">Quick Actions</h3>
            
            <div class="space-y-3">
              <router-link
                to="/learn"
                class="block w-full bg-teal-800 text-white px-4 py-3 rounded-lg font-medium hover:bg-teal-700 transition-colors duration-200 text-center"
              >
                Browse Modules
              </router-link>
              
              <router-link
                to="/achievements"
                class="block w-full bg-yellow-400 text-teal-800 px-4 py-3 rounded-lg font-medium hover:bg-yellow-300 transition-colors duration-200 text-center"
              >
                View Badges
              </router-link>
              
              <router-link
                to="/stories"
                class="block w-full bg-gray-100 text-gray-700 px-4 py-3 rounded-lg font-medium hover:bg-gray-200 transition-colors duration-200 text-center"
              >
                Share Your Story
              </router-link>
            </div>
          </div>

          <!-- Daily Tip -->
          <div class="bg-gradient-to-br from-teal-50 to-blue-50 rounded-xl border border-teal-200 p-6">
            <h3 class="text-lg font-heading font-bold text-teal-800 mb-3">💡 Daily Tip</h3>
            <p class="text-gray-700 text-sm">
              {{ dailyTip }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { useAuth } from '../../stores/auth'
import { useModules } from '../../stores/modules'
import { useAchievements } from '../../stores/achievements'

const { user } = useAuth()
const { 
  modules, 
  userProgress, 
  loading, 
  fetchModules, 
  fetchUserProgress,
  getCompletedModulesCount,
  getAverageScore
} = useModules()
const { getUserAchievements, shareAchievement } = useAchievements()

const userAchievements = ref<any[]>([])
const currentStreak = ref(5) // This would be calculated based on user activity

const completedCount = computed(() => getCompletedModulesCount())
const averageScore = computed(() => getAverageScore())

const suggestedModules = computed(() => {
  // Show incomplete modules first, then completed ones for review
  const incomplete = modules.value.filter(module => {
    const progress = getModuleProgress(module.id)
    return !progress?.completed
  })
  
  const completed = modules.value.filter(module => {
    const progress = getModuleProgress(module.id)
    return progress?.completed
  })
  
  return [...incomplete.slice(0, 3), ...completed.slice(0, 2)]
})

const recentAchievements = computed(() => {
  return userAchievements.value.slice(0, 3)
})

const dailyTip = ref("Remember: in an emergency, your safety comes first. Never put yourself in danger to help someone else.")

const getModuleProgress = (moduleId: string) => {
  return userProgress.value.find(p => p.module_id === moduleId)
}

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  const now = new Date()
  const diffTime = Math.abs(now.getTime() - date.getTime())
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
  
  if (diffDays === 1) return 'yesterday'
  if (diffDays < 7) return `${diffDays} days ago`
  return date.toLocaleDateString()
}

onMounted(async () => {
  if (user.value) {
    await Promise.all([
      fetchModules(),
      fetchUserProgress(user.value.id)
    ])
    
    // Fetch user achievements
    const { data } = await getUserAchievements(user.value.id)
    if (data) {
      userAchievements.value = data
    }
  }
})
</script>