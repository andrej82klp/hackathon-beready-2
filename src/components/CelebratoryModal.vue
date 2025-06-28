<template>
  <div
    v-if="showCelebratoryModal"
    class="fixed inset-0 z-50 overflow-y-auto"
    aria-labelledby="modal-title"
    role="dialog"
    aria-modal="true"
  >
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      <div class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity" aria-hidden="true"></div>

      <span class="hidden sm:inline-block sm:align-middle sm:h-screen" aria-hidden="true">&#8203;</span>

      <div class="relative inline-block align-bottom bg-white rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full sm:p-6">
        <div class="text-center">
          <!-- Celebration Animation -->
          <div class="mx-auto flex items-center justify-center h-24 w-24 rounded-full bg-yellow-100 mb-4">
            <div class="text-4xl animate-bounce">🏆</div>
          </div>

          <h3 class="text-2xl leading-6 font-heading font-bold text-teal-800 mb-2" id="modal-title">
            Congratulations!
          </h3>

          <div class="mt-4">
            <p class="text-lg text-gray-700 mb-4">
              You've earned your <strong>{{ currentAchievement?.badge_name }}</strong> badge!
            </p>
            
            <div class="bg-yellow-50 border-2 border-yellow-200 rounded-lg p-4 mb-6">
              <div class="flex items-center justify-center mb-2">
                <div class="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center">
                  <span class="text-2xl">🏅</span>
                </div>
              </div>
              <p class="font-semibold text-teal-800">{{ currentAchievement?.badge_name }}</p>
              <p class="text-sm text-gray-600">Earned on {{ formatDate(currentAchievement?.earned_at) }}</p>
            </div>

            <p class="text-gray-600 mb-6">
              You're building valuable skills that could save lives. Share your achievement and inspire others to be ready!
            </p>

            <!-- Social Sharing Buttons -->
            <div class="flex flex-col sm:flex-row gap-3 mb-6">
              <button
                @click="shareOnFacebook"
                class="flex-1 bg-blue-600 text-white px-4 py-2 rounded-lg font-semibold hover:bg-blue-700 transition-colors duration-200 flex items-center justify-center"
              >
                <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                </svg>
                Share on Facebook
              </button>
              <button
                @click="shareOnTwitter"
                class="flex-1 bg-black text-white px-4 py-2 rounded-lg font-semibold hover:bg-gray-800 transition-colors duration-200 flex items-center justify-center"
              >
                <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                  <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
                </svg>
                Share on X
              </button>
            </div>
          </div>
        </div>

        <div class="mt-5 sm:mt-6 flex flex-col sm:flex-row gap-3">
          <router-link
            to="/achievements"
            class="flex-1 bg-teal-800 text-white px-4 py-2 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200 text-center"
            @click="closeCelebratoryModal"
          >
            View All Badges
          </router-link>
          <button
            @click="closeCelebratoryModal"
            class="flex-1 bg-gray-200 text-gray-700 px-4 py-2 rounded-lg font-semibold hover:bg-gray-300 transition-colors duration-200"
          >
            Continue Learning
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { useAchievements } from '../stores/achievements'

const {
  showCelebratoryModal,
  currentAchievement,
  closeCelebratoryModal,
  shareAchievement
} = useAchievements()

const formatDate = (dateString?: string) => {
  if (!dateString) return ''
  return new Date(dateString).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const shareOnFacebook = () => {
  if (currentAchievement.value) {
    shareAchievement('facebook', currentAchievement.value.badge_name)
  }
}

const shareOnTwitter = () => {
  if (currentAchievement.value) {
    shareAchievement('twitter', currentAchievement.value.badge_name)
  }
}
</script>