import { ref } from 'vue'
import { achievementService } from '../lib/supabase'
import type { Achievement } from '../lib/supabase'
import { BRAND_NAME } from '../lib/config'

const showCelebratoryModal = ref(false)
const currentAchievement = ref<Achievement | null>(null)

export const useAchievements = () => {
  const earnBadge = async (userId: string, badgeName: string, moduleId?: string) => {
    // Ensure user is authenticated before earning badges
    if (!userId) {
      console.warn('User must be authenticated to earn badges')
      return { data: null, error: new Error('Authentication required'), alreadyEarned: false }
    }
    
    try {
      const { data, error, alreadyEarned } = await achievementService.earnBadge(userId, badgeName, moduleId)

      if (error) throw error

      // Only show celebratory modal for new achievements
      if (!alreadyEarned && data) {
        currentAchievement.value = data
        showCelebratoryModal.value = true
      }

      return { data, error: null, alreadyEarned }
    } catch (error) {
      console.error('Error earning badge:', error)
      return { data: null, error, alreadyEarned: false }
    }
  }

  const getUserAchievements = async (userId: string) => {
    try {
      const { data, error } = await achievementService.getUserAchievements(userId)
      if (error) throw error
      return { data, error: null }
    } catch (error) {
      console.error('Error fetching achievements:', error)
      return { data: null, error }
    }
  }

  const closeCelebratoryModal = () => {
    showCelebratoryModal.value = false
    currentAchievement.value = null
  }

  const shareAchievement = (platform: 'facebook' | 'twitter', badgeName: string) => {
    const text = `I just earned my ${badgeName} badge from ${BRAND_NAME}! I'm learning to be ready to act when it matters most.`
    const url = window.location.origin
    
    if (platform === 'facebook') {
      window.open(`https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(url)}&quote=${encodeURIComponent(text)}`, '_blank')
    } else {
      window.open(`https://x.com/intent/tweet?text=${encodeURIComponent(text)}&url=${encodeURIComponent(url)}`, '_blank')
    }
  }

  return {
    showCelebratoryModal,
    currentAchievement,
    earnBadge,
    getUserAchievements,
    closeCelebratoryModal,
    shareAchievement
  }
}