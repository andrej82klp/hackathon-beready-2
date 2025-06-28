<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="text-center mb-12">
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          Your Achievement Badges
        </h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto">
          Celebrate your progress in first aid education. Each badge represents valuable skills 
          you've mastered that could help save lives.
        </p>
      </div>

      <!-- Progress Summary -->
      <div class="bg-white rounded-xl shadow-lg p-8 mb-8">
        <div class="text-center">
          <div class="inline-flex items-center space-x-2 bg-yellow-100 px-4 py-2 rounded-full mb-4">
            <span class="text-2xl">🏆</span>
            <span class="font-semibold text-yellow-800">{{ earnedBadges.length }} of {{ allBadges.length }} Badges Earned</span>
          </div>
          
          <div class="w-full bg-gray-200 rounded-full h-3 mb-4">
            <div
              class="bg-yellow-400 h-3 rounded-full transition-all duration-500"
              :style="{ width: progressPercentage + '%' }"
            ></div>
          </div>
          
          <p class="text-gray-600">
            You're {{ progressPercentage }}% of the way to becoming a BeReady First Aid Hero!
          </p>
        </div>
      </div>

      <!-- Badge Categories -->
      <div class="mb-8">
        <div class="flex flex-wrap justify-center gap-4">
          <button
            v-for="category in categories"
            :key="category"
            @click="selectedCategory = category"
            class="px-4 py-2 rounded-lg font-medium transition-colors duration-200"
            :class="selectedCategory === category 
              ? 'bg-teal-800 text-white' 
              : 'bg-white text-gray-700 hover:bg-gray-100'"
          >
            {{ category }}
          </button>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="text-center py-12">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-teal-800"></div>
        <p class="mt-4 text-gray-600">Loading achievements...</p>
      </div>

      <!-- Badges Grid -->
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
        <div
          v-for="badge in filteredBadges"
          :key="badge.id"
          class="bg-white rounded-xl shadow-lg overflow-hidden transition-all duration-300 hover:shadow-xl"
          :class="badge.earned ? 'transform hover:-translate-y-2' : 'opacity-60'"
        >
          <!-- Badge Image/Icon -->
          <div
            class="h-48 flex items-center justify-center text-6xl"
            :class="badge.earned ? 'bg-gradient-to-br from-yellow-100 to-yellow-200' : 'bg-gray-100'"
          >
            <span v-if="badge.earned">🏅</span>
            <span v-else class="text-gray-400">🔒</span>
          </div>

          <!-- Badge Info -->
          <div class="p-6">
            <h3 class="text-xl font-heading font-bold mb-2"
                :class="badge.earned ? 'text-teal-800' : 'text-gray-500'">
              {{ badge.name }}
            </h3>
            
            <p class="text-gray-600 text-sm mb-4">
              {{ badge.description }}
            </p>

            <div class="flex items-center justify-between">
              <span class="inline-block bg-gray-100 text-gray-600 px-2 py-1 rounded text-xs font-medium">
                {{ badge.category }}
              </span>
              
              <div v-if="badge.earned" class="text-xs text-gray-500">
                Earned {{ formatDate(badge.earned_at) }}
              </div>
              <div v-else class="text-xs text-gray-400">
                Not earned yet
              </div>
            </div>

            <!-- Action Buttons -->
            <div class="mt-4 flex gap-2">
              <div v-if="badge.earned" class="flex gap-2 flex-1">
                <button
                  @click="shareBadge(badge, 'facebook')"
                  class="flex-1 bg-blue-600 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:bg-blue-700 transition-colors duration-200 flex items-center justify-center"
                >
                  <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                  </svg>
                  Facebook
                </button>
                
                <button
                  @click="shareBadge(badge, 'twitter')"
                  class="flex-1 bg-black text-white px-3 py-2 rounded-lg text-sm font-semibold hover:bg-gray-800 transition-colors duration-200 flex items-center justify-center"
                >
                  <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 24 24">
                    <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
                  </svg>
                  X
                </button>
              </div>
              
              <router-link
                v-if="!badge.earned"
                :to="`/learn/${badge.moduleId}`"
                class="flex-1 bg-teal-800 text-white px-3 py-2 rounded-lg text-sm font-semibold hover:bg-teal-700 transition-colors duration-200 text-center"
              >
                Start Learning
              </router-link>
              
              <router-link
                v-if="badge.earned"
                :to="`/learn/${badge.moduleId}`"
                class="flex-1 bg-gray-100 text-gray-700 px-3 py-2 rounded-lg text-sm font-semibold hover:bg-gray-200 transition-colors duration-200 text-center"
              >
                Review
              </router-link>
            </div>
          </div>
        </div>
      </div>

      <!-- Next Steps -->
      <div v-if="nextBadgeToEarn" class="mt-12 bg-gradient-to-r from-teal-800 to-teal-600 rounded-xl p-8 text-white text-center">
        <h2 class="text-2xl font-heading font-bold mb-4">
          Your Next Badge: {{ nextBadgeToEarn.name }}
        </h2>
        <p class="text-lg mb-6 text-gray-100">
          {{ nextBadgeToEarn.description }}
        </p>
        <router-link
          :to="`/learn/${nextBadgeToEarn.moduleId}`"
          class="inline-block bg-yellow-400 text-teal-800 px-8 py-3 rounded-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
        >
          Start Learning Now
        </router-link>
      </div>

      <!-- Share All Achievement -->
      <div v-if="earnedBadges.length > 0" class="mt-8 text-center">
        <div class="bg-yellow-50 rounded-xl border-2 border-yellow-200 p-8">
          <h3 class="text-2xl font-heading font-bold text-teal-800 mb-4">
            Share Your Progress
          </h3>
          <p class="text-gray-700 mb-6">
            Let your friends and family know about your first aid achievements and inspire them to be ready too!
          </p>
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <button
              @click="shareProgress('facebook')"
              class="bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors duration-200 flex items-center justify-center"
            >
              <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
              </svg>
              Share on Facebook
            </button>
            <button
              @click="shareProgress('twitter')"
              class="bg-black text-white px-6 py-3 rounded-lg font-semibold hover:bg-gray-800 transition-colors duration-200 flex items-center justify-center"
            >
              <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
              </svg>
              Share on X
            </button>
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
import { BRAND_NAME } from '../../lib/config'

const { user } = useAuth()
const { modules, fetchModules } = useModules()
const { getUserAchievements, shareAchievement } = useAchievements()

const selectedCategory = ref('All')
const userAchievements = ref<any[]>([])
const loading = ref(true)

const categories = ['All', 'Basic Skills', 'Emergency Response', 'Advanced Care']

const allBadges = computed(() => {
  return modules.value.map(module => {
    const achievement = userAchievements.value.find(a => a.badge_name === module.badge_name)
    return {
      id: module.id,
      name: module.badge_name,
      description: `Mastered ${module.title.toLowerCase()} skills and techniques.`,
      category: getCategoryForModule(module.difficulty),
      moduleId: module.id,
      earned: !!achievement,
      earned_at: achievement?.earned_at || null
    }
  })
})

const earnedBadges = computed(() => allBadges.value.filter(badge => badge.earned))

const filteredBadges = computed(() => {
  if (selectedCategory.value === 'All') {
    return allBadges.value
  }
  return allBadges.value.filter(badge => badge.category === selectedCategory.value)
})

const progressPercentage = computed(() => 
  allBadges.value.length > 0 ? Math.round((earnedBadges.value.length / allBadges.value.length) * 100) : 0
)

const nextBadgeToEarn = computed(() => 
  allBadges.value.find(badge => !badge.earned)
)

const getCategoryForModule = (difficulty: string) => {
  switch (difficulty) {
    case 'beginner':
      return 'Basic Skills'
    case 'intermediate':
      return 'Emergency Response'
    case 'advanced':
      return 'Advanced Care'
    default:
      return 'Basic Skills'
  }
}

const formatDate = (dateString: string | null) => {
  if (!dateString) return ''
  const date = new Date(dateString)
  const now = new Date()
  const diffTime = Math.abs(now.getTime() - date.getTime())
  const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24))
  
  if (diffDays === 1) return 'yesterday'
  if (diffDays < 7) return `${diffDays} days ago`
  return date.toLocaleDateString()
}

const shareBadge = (badge: any, platform: 'facebook' | 'twitter') => {
  shareAchievement(platform, badge.name)
}

const shareProgress = (platform: 'facebook' | 'twitter') => {
  const text = `I've earned ${earnedBadges.value.length} first aid badges on BeReady! I'm building skills to be ready when it matters most. Join me! #BeReadyToAct`
  const url = window.location.origin
  
  if (platform === 'facebook') {
    window.open(`https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(url)}&quote=${encodeURIComponent(text)}`, '_blank')
  } else {
    window.open(`https://twitter.com/intent/tweet?text=${encodeURIComponent(text)}&url=${encodeURIComponent(url)}`, '_blank')
  }
}

onMounted(async () => {
  loading.value = true
  
  try {
    await fetchModules()
    
    if (user.value) {
      const { data } = await getUserAchievements(user.value.id)
      if (data) {
        userAchievements.value = data
      }
    }
  } catch (error) {
    console.error('Error loading achievements:', error)
  } finally {
    loading.value = false
  }
})
</script>