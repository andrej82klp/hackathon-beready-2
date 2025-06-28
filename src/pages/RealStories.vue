<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="text-center mb-12">
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          Real Stories from Real Heroes
        </h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto">
          Discover how ordinary people used their first aid knowledge to make an extraordinary difference 
          when it mattered most. Their stories remind us why being prepared is so important.
        </p>
      </div>

      <!-- Share Story CTA -->
      <div v-if="isAuthenticated" class="bg-yellow-50 rounded-2xl border-2 border-yellow-200 p-8 mb-12 text-center">
        <div class="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="text-3xl">✍️</span>
        </div>
        <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">
          Have a Story to Share?
        </h2>
        <p class="text-gray-700 mb-6 max-w-2xl mx-auto">
          Your experience could inspire others to learn first aid and be prepared. 
          Share how your knowledge made a difference.
        </p>
        <button
          @click="showShareForm = true"
          class="bg-yellow-400 text-teal-800 px-8 py-3 rounded-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
        >
          Share Your Story
        </button>
      </div>

      <!-- Authentication Required Message -->
      <div v-if="!isAuthenticated" class="bg-blue-50 rounded-2xl border-2 border-blue-200 p-8 mb-12 text-center">
        <div class="w-16 h-16 bg-blue-400 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="text-3xl">🔐</span>
        </div>
        <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">
          Share Your Story
        </h2>
        <p class="text-gray-700 mb-6 max-w-2xl mx-auto">
          To share your first aid story and inspire others, please log in to your account first.
        </p>
        <router-link
          to="/login"
          class="bg-blue-400 text-white px-8 py-3 rounded-lg font-bold hover:bg-blue-300 transition-colors duration-200 inline-block"
        >
          Log In to Share
        </router-link>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="text-center py-12">
        <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-teal-800"></div>
        <p class="mt-4 text-gray-600">Loading stories...</p>
      </div>

      <!-- Stories Grid -->
      <div v-else class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <div
          v-for="story in stories"
          :key="story.id"
          class="bg-white rounded-xl shadow-lg p-6 hover:shadow-xl transition-shadow duration-300"
        >
          <!-- Story Header -->
          <div class="flex items-center mb-4">
            <div class="w-12 h-12 bg-teal-100 rounded-full flex items-center justify-center">
              <span class="text-teal-800 font-bold text-lg">{{ story.name.charAt(0) }}</span>
            </div>
            <div class="ml-3">
              <h3 class="font-semibold text-teal-800">{{ story.name }}</h3>
              <p class="text-sm text-gray-500">{{ story.location }}</p>
            </div>
          </div>

          <!-- Story Content -->
          <blockquote class="text-gray-700 italic mb-4 leading-relaxed">
            "{{ story.story }}"
          </blockquote>

          <!-- Story Meta -->
          <div class="flex items-center justify-between text-sm text-gray-500">
            <span>{{ formatDate(story.created_at) }}</span>
            <div class="flex items-center space-x-1">
              <span class="text-yellow-400">⭐</span>
              <span>Inspiring</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-if="!loading && stories.length === 0" class="text-center py-12">
        <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="text-3xl">📖</span>
        </div>
        <h3 class="text-xl font-heading font-bold text-gray-800 mb-2">No Stories Yet</h3>
        <p class="text-gray-600">Be the first to share your first aid story!</p>
      </div>

      <!-- Load More -->
      <div v-if="stories.length > 0" class="text-center mt-12">
        <button
          @click="loadMoreStories"
          class="bg-teal-800 text-white px-8 py-3 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200"
        >
          Load More Stories
        </button>
      </div>

      <!-- Share Story Modal -->
      <div
        v-if="showShareForm && isAuthenticated"
        class="fixed inset-0 z-50 overflow-y-auto bg-black bg-opacity-50 flex items-center justify-center p-4"
      >
        <div class="bg-white rounded-xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
          <div class="p-8">
            <div class="flex items-center justify-between mb-6">
              <h3 class="text-2xl font-heading font-bold text-teal-800">
                Share Your Story
              </h3>
              <button
                @click="closeShareForm"
                class="text-gray-400 hover:text-gray-600"
              >
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>

            <form @submit.prevent="submitStoryForm" class="space-y-6">
              <div>
                <label for="name" class="block text-sm font-medium text-gray-700 mb-2">
                  Your Name
                </label>
                <input
                  id="name"
                  v-model="storyForm.name"
                  type="text"
                  required
                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
                  placeholder="How would you like to be identified?"
                />
              </div>

              <div>
                <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                  Email Address
                </label>
                <input
                  id="email"
                  v-model="storyForm.email"
                  type="email"
                  required
                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
                  placeholder="We'll keep this private"
                />
              </div>

              <div>
                <label for="location" class="block text-sm font-medium text-gray-700 mb-2">
                  Location (Optional)
                </label>
                <input
                  id="location"
                  v-model="storyForm.location"
                  type="text"
                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
                  placeholder="City, State"
                />
              </div>

              <div>
                <label for="story" class="block text-sm font-medium text-gray-700 mb-2">
                  Your Story
                </label>
                <textarea
                  id="story"
                  v-model="storyForm.story"
                  rows="6"
                  required
                  class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
                  placeholder="Tell us about a time when first aid knowledge made a difference. What happened? How did you help? What did you learn?"
                ></textarea>
                <p class="text-sm text-gray-500 mt-1">
                  Share as much detail as you're comfortable with. Your story could inspire others to learn first aid.
                </p>
              </div>

              <div class="bg-gray-50 rounded-lg p-4">
                <div class="flex items-start">
                  <input
                    id="consent"
                    v-model="storyForm.consent"
                    type="checkbox"
                    required
                    class="mt-1 h-4 w-4 text-teal-800 focus:ring-teal-800 border-gray-300 rounded"
                  />
                  <label for="consent" class="ml-2 text-sm text-gray-700">
                    I consent to sharing my story on the {{ BRAND_NAME }} platform to inspire others. 
                    I understand that my story will be reviewed before publication and may be edited for clarity.
                  </label>
                </div>
              </div>

              <div class="flex flex-col sm:flex-row gap-3">
                <button
                  type="submit"
                  :disabled="submitting"
                  class="flex-1 bg-yellow-400 text-teal-800 px-6 py-3 rounded-lg font-bold hover:bg-yellow-300 transition-colors duration-200 disabled:opacity-50"
                >
                  {{ submitting ? 'Submitting...' : 'Share My Story' }}
                </button>
                <button
                  type="button"
                  @click="closeShareForm"
                  class="flex-1 bg-gray-200 text-gray-700 px-6 py-3 rounded-lg font-semibold hover:bg-gray-300 transition-colors duration-200"
                >
                  Cancel
                </button>
              </div>
            </form>

            <div v-if="submitSuccess" class="mt-4 bg-green-50 border border-green-200 rounded-lg p-4">
              <div class="flex">
                <div class="flex-shrink-0">
                  <svg class="h-5 w-5 text-green-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                  </svg>
                </div>
                <div class="ml-3">
                  <h3 class="text-sm font-medium text-green-800">
                    Thank you for sharing your story! We'll review it and publish it soon.
                  </h3>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useStories } from '../stores/stories'
import { useAuth } from '../stores/auth'
import { supabase } from '../lib/supabase'
import { BRAND_NAME } from '../lib/config'

const { stories, loading, fetchStories, submitStory } = useStories()
const { isAuthenticated } = useAuth()

const showShareForm = ref(false)
const submitting = ref(false)
const submitSuccess = ref(false)

const storyForm = ref({
  name: '',
  email: '',
  location: '',
  story: '',
  consent: false
})

const formatDate = (dateString: string) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

const closeShareForm = () => {
  showShareForm.value = false
  submitSuccess.value = false
  storyForm.value = {
    name: '',
    email: '',
    location: '',
    story: '',
    consent: false
  }
}

const submitStoryForm = async () => {
  submitting.value = true
  
  try {
    // Debug: Log current session and user
    const session = await supabase.auth.getSession();
    console.log('Supabase session:', session);
    const user = session.data?.session?.user;
    console.log('Supabase user:', user);

    await submitStory(
      storyForm.value.name,
      storyForm.value.email,
      storyForm.value.story,
      storyForm.value.location || undefined
    )
    
    submitSuccess.value = true
    
    // Close form after success
    setTimeout(() => {
      closeShareForm()
    }, 3000)
    
  } catch (error) {
    console.error('Error submitting story:', error)
    // Show more specific error message
    const errorMessage = error instanceof Error ? error.message : 'Unknown error occurred'
    alert(`There was an error submitting your story: ${errorMessage}. Please try again.`)
  } finally {
    submitting.value = false
  }
}

const loadMoreStories = () => {
  // In a real app, this would load more stories with pagination
  console.log('Loading more stories...')
}

onMounted(async () => {
  await fetchStories()
})
</script>