<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="text-center mb-12">
        <div class="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center mx-auto mb-6">
          <span class="text-3xl">💬</span>
        </div>
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          We Value Your Feedback
        </h1>
        <p class="text-xl text-gray-600 max-w-2xl mx-auto">
          Help us improve BeReady by sharing your thoughts, suggestions, and experiences. 
          Your input directly shapes how we build better first aid education.
        </p>
      </div>

      <!-- Feedback Form -->
      <div class="bg-white rounded-xl shadow-lg p-8">
        <form @submit.prevent="submitFeedback" class="space-y-6">
          <!-- Feedback Type -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-3">
              What type of feedback are you sharing?
            </label>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-3">
              <button
                v-for="type in feedbackTypes"
                :key="type.value"
                type="button"
                @click="feedbackForm.type = type.value"
                class="p-4 border-2 rounded-lg transition-colors duration-200 text-left"
                :class="feedbackForm.type === type.value 
                  ? 'border-teal-800 bg-teal-50 text-teal-800' 
                  : 'border-gray-200 hover:border-gray-300'"
              >
                <div class="text-2xl mb-2">{{ type.icon }}</div>
                <div class="font-semibold">{{ type.label }}</div>
                <div class="text-sm text-gray-600">{{ type.description }}</div>
              </button>
            </div>
          </div>

          <!-- Subject -->
          <div>
            <label for="subject" class="block text-sm font-medium text-gray-700 mb-2">
              Subject
            </label>
            <input
              id="subject"
              v-model="feedbackForm.subject"
              type="text"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
              placeholder="Brief summary of your feedback"
            />
          </div>

          <!-- Message -->
          <div>
            <label for="message" class="block text-sm font-medium text-gray-700 mb-2">
              Your Feedback
            </label>
            <textarea
              id="message"
              v-model="feedbackForm.message"
              rows="6"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
              placeholder="Please share your detailed feedback, suggestions, or report any issues you've encountered..."
            ></textarea>
          </div>

          <!-- Rating (for general feedback) -->
          <div v-if="feedbackForm.type === 'general'">
            <label class="block text-sm font-medium text-gray-700 mb-3">
              How would you rate your overall experience with BeReady?
            </label>
            <div class="flex items-center space-x-2">
              <button
                v-for="star in 5"
                :key="star"
                type="button"
                @click="feedbackForm.rating = star"
                class="text-2xl transition-colors duration-200"
                :class="star <= (feedbackForm.rating || 0) ? 'text-yellow-400' : 'text-gray-300 hover:text-yellow-300'"
              >
                ⭐
              </button>
              <span v-if="feedbackForm.rating" class="ml-2 text-sm text-gray-600">
                {{ ratingLabels[feedbackForm.rating - 1] }}
              </span>
            </div>
          </div>

          <!-- Contact Information -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label for="name" class="block text-sm font-medium text-gray-700 mb-1">
                Name (Optional)
              </label>
              <input
                id="name"
                v-model="feedbackForm.name"
                type="text"
                class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
                placeholder="Your name"
              />
            </div>
            
            <div>
              <label for="email" class="block text-sm font-medium text-gray-700 mb-1">
                Email (Optional)
              </label>
              <input
                id="email"
                v-model="feedbackForm.email"
                type="email"
                class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
                placeholder="your@email.com"
              />
              <p class="text-xs text-gray-500 mt-1">
                Only if you'd like us to follow up with you
              </p>
            </div>
          </div>

          <!-- Additional Options -->
          <div class="space-y-3">
            <div class="flex items-center">
              <input
                id="followUp"
                v-model="feedbackForm.allowFollowUp"
                type="checkbox"
                class="h-4 w-4 text-teal-800 focus:ring-teal-800 border-gray-300 rounded"
              />
              <label for="followUp" class="ml-2 text-sm text-gray-700">
                It's okay to contact me about this feedback
              </label>
            </div>
            
            <div class="flex items-center">
              <input
                id="anonymous"
                v-model="feedbackForm.anonymous"
                type="checkbox"
                class="h-4 w-4 text-teal-800 focus:ring-teal-800 border-gray-300 rounded"
              />
              <label for="anonymous" class="ml-2 text-sm text-gray-700">
                Submit this feedback anonymously
              </label>
            </div>
          </div>

          <!-- Submit Button -->
          <div class="pt-4">
            <button
              type="submit"
              :disabled="!isFormValid || submitting"
              class="w-full bg-yellow-400 text-teal-800 px-8 py-3 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              <span v-if="submitting">Sending Feedback...</span>
              <span v-else>Send Feedback</span>
            </button>
          </div>

          <!-- Success Message -->
          <div v-if="submitSuccess" class="bg-green-50 border border-green-200 rounded-lg p-4">
            <div class="flex">
              <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-green-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
              </div>
              <div class="ml-3">
                <h3 class="text-sm font-medium text-green-800">
                  Thank you for your feedback!
                </h3>
                <p class="text-sm text-green-700 mt-1">
                  We've received your message and will review it carefully. Your input helps us make BeReady better for everyone.
                </p>
              </div>
            </div>
          </div>
        </form>
      </div>

      <!-- FAQ Section -->
      <div class="mt-12 bg-white rounded-xl shadow-lg p-8">
        <h2 class="text-2xl font-heading font-bold text-teal-800 mb-6">
          Frequently Asked Questions
        </h2>
        
        <div class="space-y-6">
          <div>
            <h3 class="font-semibold text-gray-800 mb-2">How quickly will you respond to my feedback?</h3>
            <p class="text-gray-600">
              We review all feedback within 48 hours. If you've requested a follow-up and provided contact information, 
              we'll typically respond within 3-5 business days.
            </p>
          </div>
          
          <div>
            <h3 class="font-semibold text-gray-800 mb-2">Do you implement all suggested features?</h3>
            <p class="text-gray-600">
              While we can't implement every suggestion, we carefully consider all feedback. Features that align with our mission 
              and would benefit the most users are prioritized for development.
            </p>
          </div>
          
          <div>
            <h3 class="font-semibold text-gray-800 mb-2">Can I report technical issues here?</h3>
            <p class="text-gray-600">
              Absolutely! Please use the "Bug Report" option and include as much detail as possible about what you were doing 
              when the issue occurred, what device/browser you're using, and any error messages you saw.
            </p>
          </div>
          
          <div>
            <h3 class="font-semibold text-gray-800 mb-2">Is my feedback really anonymous if I choose that option?</h3>
            <p class="text-gray-600">
              Yes, when you select anonymous feedback, we don't store any identifying information with your submission. 
              However, this means we can't follow up with you even if you've asked us to.
            </p>
          </div>
        </div>
      </div>

      <!-- Contact Alternatives -->
      <div class="mt-8 bg-teal-50 rounded-xl border border-teal-200 p-6 text-center">
        <h3 class="text-lg font-heading font-bold text-teal-800 mb-3">
          Other Ways to Reach Us
        </h3>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <a
            href="mailto:feedback@beready.org"
            class="inline-flex items-center text-teal-800 hover:text-teal-600 font-medium"
          >
            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 4.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
            </svg>
            feedback@beready.org
          </a>
          
          <a
            href="#"
            class="inline-flex items-center text-teal-800 hover:text-teal-600 font-medium"
          >
            <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
              <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
            </svg>
            @BeReadyOrg
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { BRAND_NAME, BRAND_TWITTER, BRAND_DOMAIN } from '../lib/config'

const submitting = ref(false)
const submitSuccess = ref(false)

const feedbackTypes = [
  {
    value: 'general',
    label: 'General Feedback',
    description: 'Overall experience and suggestions',
    icon: '💭'
  },
  {
    value: 'bug',
    label: 'Bug Report',
    description: 'Technical issues or errors',
    icon: '🐛'
  },
  {
    value: 'feature',
    label: 'Feature Request',
    description: 'New features or improvements',
    icon: '💡'
  }
]

const ratingLabels = ['Poor', 'Fair', 'Good', 'Very Good', 'Excellent']

const feedbackForm = ref({
  type: 'general',
  subject: '',
  message: '',
  rating: null as number | null,
  name: '',
  email: '',
  allowFollowUp: false,
  anonymous: false
})

const isFormValid = computed(() => {
  return feedbackForm.value.type && 
         feedbackForm.value.subject.trim() && 
         feedbackForm.value.message.trim()
})

const submitFeedback = async () => {
  if (!isFormValid.value) return

  submitting.value = true
  submitSuccess.value = false

  try {
    // Simulate API call
    await new Promise(resolve => setTimeout(resolve, 1500))
    
    // In a real app, this would submit to Supabase or email service
    console.log('Feedback submitted:', feedbackForm.value)
    
    submitSuccess.value = true
    
    // Reset form after success
    setTimeout(() => {
      feedbackForm.value = {
        type: 'general',
        subject: '',
        message: '',
        rating: null,
        name: '',
        email: '',
        allowFollowUp: false,
        anonymous: false
      }
      submitSuccess.value = false
    }, 5000)
    
  } catch (error) {
    console.error('Error submitting feedback:', error)
  } finally {
    submitting.value = false
  }
}
</script>