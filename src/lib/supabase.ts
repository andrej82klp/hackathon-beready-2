import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL || 'https://your-project.supabase.co'
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY || 'your-anon-key'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)

export interface User {
  id: string
  email: string
  created_at: string
}

export interface Module {
  id: string
  title: string
  description: string
  content: string
  difficulty: 'beginner' | 'intermediate' | 'advanced'
  badge_name: string
  duration: string
  icon: string
  live: boolean
  created_at: string
  updated_at: string
}

export interface UserProgress {
  id: string
  user_id: string
  module_id: string
  completed: boolean
  score?: number
  started_at: string
  completed_at?: string
  created_at: string
  updated_at: string
}

export interface Achievement {
  id: string
  user_id: string
  badge_name: string
  module_id?: string
  earned_at: string
  created_at: string
}

export interface Story {
  id: string
  name: string
  email: string
  story: string
  location?: string
  approved: boolean
  featured: boolean
  created_at: string
  updated_at: string
}

export interface Test {
  id: string
  module_id: string
  description?: string
  created_at: string
  updated_at: string
}

export interface Question {
  id: string
  test_id: string
  question_text: string
  options: Array<{ text: string; is_correct: boolean }>
  created_at: string
  updated_at: string
}

// Database service functions
export const moduleService = {
  async getAll() {
    const { data, error } = await supabase
      .from('modules')
      .select('*')
      .eq('live', true)
      .order('created_at', { ascending: true })
    
    return { data, error }
  },

  async getById(id: string) {
    const { data, error } = await supabase
      .from('modules')
      .select('*')
      .eq('id', id)
      .eq('live', true)
      .single()
    
    return { data, error }
  },

  async getByTitle(title: string) {
    const { data, error } = await supabase
      .from('modules')
      .select('*')
      .eq('title', title)
      .eq('live', true)
      .single()
    
    return { data, error }
  }
}

export const progressService = {
  async getUserProgress(userId: string) {
    const { data, error } = await supabase
      .from('user_progress')
      .select(`
        *,
        modules (
          id,
          title,
          badge_name,
          difficulty,
          duration,
          icon
        )
      `)
      .eq('user_id', userId)
      .order('updated_at', { ascending: false })
    
    return { data, error }
  },

  async getModuleProgress(userId: string, moduleId: string) {
    const { data, error } = await supabase
      .from('user_progress')
      .select('*')
      .eq('user_id', userId)
      .eq('module_id', moduleId)
      .single()
    
    return { data, error }
  },

  async startModule(userId: string, moduleId: string) {
    const { data, error } = await supabase
      .from('user_progress')
      .upsert({
        user_id: userId,
        module_id: moduleId,
        started_at: new Date().toISOString()
      }, {
        onConflict: 'user_id,module_id'
      })
      .select()
      .single()
    
    return { data, error }
  },

  async completeModule(userId: string, moduleId: string, score: number) {
    const { data, error } = await supabase
      .from('user_progress')
      .upsert({
        user_id: userId,
        module_id: moduleId,
        completed: true,
        score: score,
        completed_at: new Date().toISOString()
      }, {
        onConflict: 'user_id,module_id'
      })
      .select()
      .single()
    
    return { data, error }
  }
}

export const achievementService = {
  async getUserAchievements(userId: string) {
    const { data, error } = await supabase
      .from('achievements')
      .select(`
        *,
        modules (
          id,
          title,
          icon
        )
      `)
      .eq('user_id', userId)
      .order('earned_at', { ascending: false })
    
    return { data, error }
  },

  async earnBadge(userId: string, badgeName: string, moduleId?: string) {
    // Check if user already has this badge
    const { data: existing } = await supabase
      .from('achievements')
      .select('id')
      .eq('user_id', userId)
      .eq('badge_name', badgeName)
      .single()

    if (existing) {
      return { data: existing, error: null, alreadyEarned: true }
    }

    const { data, error } = await supabase
      .from('achievements')
      .insert({
        user_id: userId,
        badge_name: badgeName,
        module_id: moduleId,
        earned_at: new Date().toISOString()
      })
      .select()
      .single()
    
    return { data, error, alreadyEarned: false }
  }
}

export const storyService = {
  async getApprovedStories() {
    const { data, error } = await supabase
      .from('stories')
      .select('*')
      .eq('approved', true)
      .order('created_at', { ascending: false })
    
    return { data, error }
  },

  async getFeaturedStories() {
    const { data, error } = await supabase
      .from('stories')
      .select('*')
      .eq('approved', true)
      .eq('featured', true)
      .order('created_at', { ascending: false })
      .limit(6)
    
    return { data, error }
  },

  async submitStory(name: string, email: string, story: string, location?: string) {
    const { data, error } = await supabase
      .from('stories')
      .insert({
        name,
        email,
        story,
        location,
        approved: false, // Stories need approval - required by RLS policy
        featured: false  // Explicitly set featured to false
      })
    
    return { data, error }
  }
}

export const testService = {
  async getTestByModuleId(moduleId: string) {
    const { data, error } = await supabase
      .from('tests')
      .select('*')
      .eq('module_id', moduleId)
      .single()
    
    return { data, error }
  },

  async getQuestionsByTestId(testId: string) {
    const { data, error } = await supabase
      .from('questions')
      .select('*')
      .eq('test_id', testId)
      .order('created_at', { ascending: true })
    
    return { data, error }
  }
}