import { ref, computed } from 'vue'
import { supabase } from '../lib/supabase'
import type { User } from '@supabase/supabase-js'

const user = ref<User | null>(null)
const loading = ref(true)

// Initialize auth state
supabase.auth.getSession().then(({ data: { session } }) => {
  user.value = session?.user ?? null
  loading.value = false
})

// Listen for auth changes
supabase.auth.onAuthStateChange((_, session) => {
  user.value = session?.user ?? null
  loading.value = false
})

export const useAuth = () => {
  const isAuthenticated = computed(() => !!user.value)

  const signUp = async (email: string, password: string) => {
    try {
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          emailRedirectTo: `${window.location.origin}/dashboard`
        }
      })
      if (error) throw error
      return { data, error: null }
    } catch (error) {
      return { data: null, error }
    }
  }

  const signIn = async (email: string, password: string) => {
    try {
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password
      })
      if (error) throw error
      return { data, error: null }
    } catch (error) {
      return { data: null, error }
    }
  }

  const signOut = async () => {
    try {
      const { error } = await supabase.auth.signOut()
      if (error) throw error
      return { error: null }
    } catch (error) {
      return { error }
    }
  }

  return {
    user: user,
    loading,
    isAuthenticated,
    signUp,
    signIn,
    signOut
  }
}