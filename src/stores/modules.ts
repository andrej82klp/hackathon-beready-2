import { ref } from 'vue'
import { moduleService, progressService } from '../lib/supabase'
import type { Module, UserProgress } from '../lib/supabase'

export const useModules = () => {
  const modules = ref<Module[]>([])
  const userProgress = ref<UserProgress[]>([])
  const loading = ref(false)

  const fetchModules = async () => {
    loading.value = true
    try {
      const { data, error } = await moduleService.getAll()
      if (error) throw error
      modules.value = data || []
      return { data, error: null }
    } catch (error) {
      console.error('Error fetching modules:', error)
      return { data: null, error }
    } finally {
      loading.value = false
    }
  }

  const fetchModuleById = async (id: string) => {
    try {
      const { data, error } = await moduleService.getById(id)
      if (error) throw error
      return { data, error: null }
    } catch (error) {
      console.error('Error fetching module:', error)
      return { data: null, error }
    }
  }

  const fetchModuleByTitle = async (title: string) => {
    try {
      const { data, error } = await moduleService.getByTitle(title)
      if (error) throw error
      return { data, error: null }
    } catch (error) {
      console.error('Error fetching module by title:', error)
      return { data: null, error }
    }
  }

  const fetchUserProgress = async (userId: string) => {
    try {
      const { data, error } = await progressService.getUserProgress(userId)
      if (error) throw error
      userProgress.value = data || []
      return { data, error: null }
    } catch (error) {
      console.error('Error fetching user progress:', error)
      return { data: null, error }
    }
  }

  const startModule = async (userId: string, moduleId: string) => {
    try {
      const { data, error } = await progressService.startModule(userId, moduleId)
      if (error) throw error
      
      // Update local progress
      await fetchUserProgress(userId)
      
      return { data, error: null }
    } catch (error) {
      console.error('Error starting module:', error)
      return { data: null, error }
    }
  }

  const completeModule = async (userId: string, moduleId: string, score: number) => {
    try {
      const { data, error } = await progressService.completeModule(userId, moduleId, score)
      if (error) throw error
      
      // Update local progress
      await fetchUserProgress(userId)
      
      return { data, error: null }
    } catch (error) {
      console.error('Error completing module:', error)
      return { data: null, error }
    }
  }

  const getModuleProgress = (moduleId: string) => {
    return userProgress.value.find(p => p.module_id === moduleId)
  }

  const getCompletedModulesCount = () => {
    return userProgress.value.filter(p => p.completed).length
  }

  const getAverageScore = () => {
    const completedWithScores = userProgress.value.filter(p => p.completed && p.score !== null)
    if (completedWithScores.length === 0) return 0
    
    const totalScore = completedWithScores.reduce((sum, p) => sum + (p.score || 0), 0)
    return totalScore / completedWithScores.length
  }

  return {
    modules,
    userProgress,
    loading,
    fetchModules,
    fetchModuleById,
    fetchModuleByTitle,
    fetchUserProgress,
    startModule,
    completeModule,
    getModuleProgress,
    getCompletedModulesCount,
    getAverageScore
  }
}