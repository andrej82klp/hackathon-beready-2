<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-3xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Success Header -->
      <div class="text-center mb-12">
        <div class="w-20 h-20 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-6">
          <span class="text-4xl">🎉</span>
        </div>
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          Thank You!
        </h1>
        <p class="text-xl text-gray-600 max-w-2xl mx-auto">
          Your generous donation helps keep first aid education free and accessible for everyone.
        </p>
      </div>

      <!-- Donation Details -->
      <div class="bg-white rounded-xl shadow-lg p-8 mb-8">
        <div class="text-center">
          <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <span class="text-3xl">💝</span>
          </div>
          
          <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">
            Donation Successful
          </h2>
          
          <div v-if="donationAmount" class="bg-yellow-50 border border-yellow-200 rounded-lg p-6 mb-6">
            <div class="text-3xl font-bold text-teal-800 mb-2">
              ${{ donationAmount }}
            </div>
            <p class="text-gray-600">
              Your contribution will make a real difference in emergency preparedness education.
            </p>
          </div>

          <div class="space-y-4 text-left max-w-md mx-auto">
            <div class="flex items-start">
              <span class="text-green-600 mr-3 mt-1">✓</span>
              <div>
                <p class="font-semibold text-gray-800">Payment Processed</p>
                <p class="text-sm text-gray-600">Your donation has been securely processed through Stripe</p>
              </div>
            </div>
            
            <div class="flex items-start">
              <span class="text-green-600 mr-3 mt-1">✓</span>
              <div>
                <p class="font-semibold text-gray-800">Receipt Sent</p>
                <p class="text-sm text-gray-600">A confirmation email has been sent to your email address</p>
              </div>
            </div>
            
            <div class="flex items-start">
              <span class="text-green-600 mr-3 mt-1">✓</span>
              <div>
                <p class="font-semibold text-gray-800">Impact Immediate</p>
                <p class="text-sm text-gray-600">Your donation is already helping us serve more learners</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Impact Message -->
      <div class="bg-gradient-to-r from-teal-800 to-teal-600 rounded-xl p-8 text-white mb-8">
        <div class="text-center">
          <h2 class="text-2xl font-heading font-bold mb-4">
            Your Impact in Action
          </h2>
          <p class="text-lg mb-6 text-gray-100">
            Thanks to supporters like you, we've been able to:
          </p>
          
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">25+</div>
              <div class="text-sm text-gray-200">People Trained</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">65+</div>
              <div class="text-sm text-gray-200">Badges Earned</div>
            </div>
            <div class="text-center">
              <div class="text-3xl font-bold mb-2">100%</div>
              <div class="text-sm text-gray-200">Free Access</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Share Your Support -->
      <div class="bg-yellow-50 rounded-xl border-2 border-yellow-200 p-8 mb-8">
        <div class="text-center">
          <h3 class="text-xl font-heading font-bold text-teal-800 mb-4">
            Spread the Word
          </h3>
          <p class="text-gray-700 mb-6">
            Help us reach more people by sharing {{ BRAND_NAME }} with your friends and family.
          </p>
          
          <div class="flex flex-col sm:flex-row gap-4 justify-center">
            <button
              @click="shareOnFacebook"
              class="bg-blue-600 text-white px-6 py-3 rounded-lg font-semibold hover:bg-blue-700 transition-colors duration-200 flex items-center justify-center"
            >
              <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24">
                <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
              </svg>
              Share on Facebook
            </button>
            
            <button
              @click="shareOnTwitter"
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

      <!-- Next Steps -->
      <div class="text-center">
        <h3 class="text-2xl font-heading font-bold text-teal-800 mb-4">
          What's Next?
        </h3>
        <p class="text-lg text-gray-600 mb-8">
          Continue exploring our free first aid modules and help build a more prepared community.
        </p>
        
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <router-link
            to="/learn"
            class="bg-teal-800 text-white px-8 py-3 rounded-lg font-bold hover:bg-teal-700 transition-colors duration-200"
          >
            Explore Learning Modules
          </router-link>
          
          <router-link
            to="/stories"
            class="bg-yellow-400 text-teal-800 px-8 py-3 rounded-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
          >
            Read Success Stories
          </router-link>
          
          <router-link
            to="/"
            class="bg-gray-100 text-gray-700 px-8 py-3 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-200"
          >
            Back to Home
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { BRAND_NAME, BRAND_TWITTER } from '../lib/config'

const route = useRoute()
const donationAmount = ref<string | null>(null)

onMounted(() => {
  // Get donation amount from URL parameters
  donationAmount.value = route.query.amount as string || null
  
  // You could also verify the session with Stripe here if needed
  const sessionId = route.query.session_id as string
  if (sessionId) {
    console.log('Payment session completed:', sessionId)
    // Optional: Call your backend to verify the session and record the donation
  }
})

const shareOnFacebook = () => {
  const text = `I just supported ${BRAND_NAME}, a platform providing free first aid education for everyone! Join me in helping build a more prepared community.`
  const url = window.location.origin
  window.open(`https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(url)}&quote=${encodeURIComponent(text)}`, '_blank')
}

const shareOnTwitter = () => {
  const text = `I just supported ${BRAND_TWITTER}, providing free first aid education for everyone! Help build a more prepared community.`
  const url = window.location.origin
  window.open(`https://x.com/intent/tweet?text=${encodeURIComponent(text)}&url=${encodeURIComponent(url)}`, '_blank')
}
</script>