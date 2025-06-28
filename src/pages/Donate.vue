<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="text-center mb-12">
        <div class="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center mx-auto mb-6">
          <span class="text-3xl">❤️</span>
        </div>
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          Support BeReady
        </h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto">
          Help us keep first aid education free and accessible for everyone. 
          Your donation directly supports our mission to build a more prepared world.
        </p>
      </div>

      <!-- Impact Statement -->
      <div class="bg-white rounded-xl shadow-lg p-8 mb-8">
        <h2 class="text-2xl font-heading font-bold text-teal-800 mb-6 text-center">
          Your Impact
        </h2>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div class="text-center p-4 bg-yellow-50 rounded-lg">
            <div class="text-3xl mb-2">📚</div>
            <h3 class="font-semibold text-teal-800 mb-2">$25</h3>
            <p class="text-sm text-gray-600">Provides free access to all modules for 5 learners</p>
          </div>
          
          <div class="text-center p-4 bg-yellow-50 rounded-lg">
            <div class="text-3xl mb-2">🎥</div>
            <h3 class="font-semibold text-teal-800 mb-2">$50</h3>
            <p class="text-sm text-gray-600">Funds creation of one new instructional video</p>
          </div>
          
          <div class="text-center p-4 bg-yellow-50 rounded-lg">
            <div class="text-3xl mb-2">🌍</div>
            <h3 class="font-semibold text-teal-800 mb-2">$100</h3>
            <p class="text-sm text-gray-600">Supports platform hosting for 1,000 users per month</p>
          </div>
        </div>
      </div>

      <!-- Donation Form -->
      <div class="bg-white rounded-xl shadow-lg p-8">
        <h2 class="text-2xl font-heading font-bold text-teal-800 mb-6">
          Make a Donation
        </h2>

        <form @submit.prevent="processDonation" class="space-y-6">
          <!-- Amount Selection -->
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-3">
              Donation Amount
            </label>
            <div class="grid grid-cols-2 md:grid-cols-4 gap-3 mb-4">
              <button
                v-for="amount in suggestedAmounts"
                :key="amount"
                type="button"
                @click="selectAmount(amount)"
                class="p-3 border-2 rounded-lg font-semibold transition-colors duration-200"
                :class="selectedAmount === amount 
                  ? 'border-yellow-400 bg-yellow-50 text-teal-800' 
                  : 'border-gray-200 hover:border-gray-300'"
              >
                ${{ amount }}
              </button>
            </div>
            
            <div class="flex items-center">
              <span class="text-gray-500 mr-2">$</span>
              <input
                v-model.number="customAmount"
                type="number"
                min="1"
                step="1"
                placeholder="Custom amount"
                class="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
                @input="selectedAmount = null"
              />
            </div>
          </div>

          <!-- Donor Information -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label for="firstName" class="block text-sm font-medium text-gray-700 mb-1">
                First Name *
              </label>
              <input
                id="firstName"
                v-model="donorInfo.firstName"
                type="text"
                required
                class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
              />
            </div>
            
            <div>
              <label for="lastName" class="block text-sm font-medium text-gray-700 mb-1">
                Last Name *
              </label>
              <input
                id="lastName"
                v-model="donorInfo.lastName"
                type="text"
                required
                class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
              />
            </div>
          </div>

          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">
              Email Address *
            </label>
            <input
              id="email"
              v-model="donorInfo.email"
              type="email"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-teal-800 focus:border-transparent"
            />
          </div>

          <!-- Additional Options -->
          <div class="space-y-3">
            <div class="flex items-center">
              <input
                id="anonymous"
                v-model="donorInfo.anonymous"
                type="checkbox"
                class="h-4 w-4 text-teal-800 focus:ring-teal-800 border-gray-300 rounded"
              />
              <label for="anonymous" class="ml-2 text-sm text-gray-700">
                Make this donation anonymous
              </label>
            </div>
            
            <div class="flex items-center">
              <input
                id="newsletter"
                v-model="donorInfo.newsletter"
                type="checkbox"
                class="h-4 w-4 text-teal-800 focus:ring-teal-800 border-gray-300 rounded"
              />
              <label for="newsletter" class="ml-2 text-sm text-gray-700">
                Send me updates about BeReady's impact
              </label>
            </div>
          </div>

          <!-- Payment Method Info -->
          <div class="bg-blue-50 border border-blue-200 rounded-lg p-4">
            <div class="flex items-center mb-2">
              <svg class="w-5 h-5 text-blue-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z" />
              </svg>
              <h3 class="font-semibold text-blue-800">Secure Payment with Stripe</h3>
            </div>
            <p class="text-sm text-blue-700">
              Your payment will be processed securely through Stripe. We accept all major credit cards.
            </p>
          </div>

          <!-- Submit Button -->
          <div class="pt-4">
            <button
              type="submit"
              :disabled="!isFormValid || processing"
              class="w-full bg-yellow-400 text-teal-800 px-8 py-4 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center"
            >
              <svg v-if="processing" class="animate-spin -ml-1 mr-3 h-5 w-5 text-teal-800" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
              </svg>
              <span v-if="processing">Processing...</span>
              <span v-else>
                Donate ${{ finalAmount }} Securely
              </span>
            </button>
          </div>

          <!-- Error Message -->
          <div v-if="error" class="mt-4 bg-red-50 border border-red-200 rounded-lg p-4">
            <div class="flex">
              <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-red-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                </svg>
              </div>
              <div class="ml-3">
                <h3 class="text-sm font-medium text-red-800">
                  {{ error }}
                </h3>
              </div>
            </div>
          </div>

          <!-- Canceled Message -->
          <div v-if="showCanceledMessage" class="mt-4 bg-yellow-50 border border-yellow-200 rounded-lg p-4">
            <div class="flex">
              <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-yellow-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
                </svg>
              </div>
              <div class="ml-3">
                <h3 class="text-sm font-medium text-yellow-800">
                  Donation Canceled
                </h3>
                <p class="text-sm text-yellow-700 mt-1">
                  Your donation was canceled. No payment was processed. You can try again anytime.
                </p>
              </div>
            </div>
          </div>

          <!-- Security Notice -->
          <div class="bg-green-50 border border-green-200 rounded-lg p-4">
            <div class="flex">
              <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-green-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M5 9V7a5 5 0 0110 0v2a2 2 0 012 2v5a2 2 0 01-2 2H5a2 2 0 01-2-2v-5a2 2 0 012-2zm8-2v2H7V7a3 3 0 016 0z" clip-rule="evenodd" />
                </svg>
              </div>
              <div class="ml-3">
                <h3 class="text-sm font-medium text-green-800">
                  Your donation is secure
                </h3>
                <p class="text-sm text-green-700 mt-1">
                  All payments are processed securely through Stripe with industry-standard encryption.
                </p>
              </div>
            </div>
          </div>
        </form>
      </div>

      <!-- Other Ways to Help -->
      <div class="mt-12 bg-teal-800 rounded-xl p-8 text-white text-center">
        <h2 class="text-2xl font-heading font-bold mb-4">
          Other Ways to Support BeReady
        </h2>
        <p class="text-gray-100 mb-6">
          Can't donate right now? There are other meaningful ways to help our mission.
        </p>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
          <div>
            <div class="text-3xl mb-2">📢</div>
            <h3 class="font-semibold mb-2">Spread the Word</h3>
            <p class="text-sm text-gray-200">Share BeReady with friends and family</p>
          </div>
          
          <div>
            <div class="text-3xl mb-2">✍️</div>
            <h3 class="font-semibold mb-2">Share Your Story</h3>
            <p class="text-sm text-gray-200">Inspire others with your first aid experience</p>
          </div>
          
          <div>
            <div class="text-3xl mb-2">💡</div>
            <h3 class="font-semibold mb-2">Give Feedback</h3>
            <p class="text-sm text-gray-200">Help us improve our platform and content</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { createDonationCheckout } from '../lib/stripe'
import type { DonationData } from '../lib/stripe'
import { BRAND_NAME } from '../lib/config'

const route = useRoute()
const selectedAmount = ref<number | null>(25)
const customAmount = ref<number | null>(null)
const processing = ref(false)
const error = ref('')
const showCanceledMessage = ref(false)

const suggestedAmounts = [10, 25, 50, 100]

const donorInfo = ref({
  firstName: '',
  lastName: '',
  email: '',
  anonymous: false,
  newsletter: true
})

// Check if user returned from canceled checkout
if (route.query.canceled === 'true') {
  showCanceledMessage.value = true
  // Hide the message after 10 seconds
  setTimeout(() => {
    showCanceledMessage.value = false
  }, 10000)
}

const finalAmount = computed(() => {
  return customAmount.value || selectedAmount.value || 0
})

const isFormValid = computed(() => {
  return finalAmount.value > 0 && 
         donorInfo.value.firstName.trim() && 
         donorInfo.value.lastName.trim() && 
         donorInfo.value.email.trim()
})

const selectAmount = (amount: number) => {
  selectedAmount.value = amount
  customAmount.value = null
}

const processDonation = async () => {
  if (!isFormValid.value) return

  processing.value = true
  error.value = ''

  try {
    const donationData: DonationData = {
      amount: finalAmount.value,
      donorName: `${donorInfo.value.firstName} ${donorInfo.value.lastName}`,
      donorEmail: donorInfo.value.email,
      anonymous: donorInfo.value.anonymous,
      newsletter: donorInfo.value.newsletter
    }

    await createDonationCheckout(donationData)
    // User will be redirected to Stripe Checkout
  } catch (err) {
    console.error('Donation processing error:', err)
    error.value = err instanceof Error ? err.message : 'There was an error processing your donation. Please try again.'
  } finally {
    processing.value = false
  }
}
</script>