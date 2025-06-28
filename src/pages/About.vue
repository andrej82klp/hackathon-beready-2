<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Hero Section -->
      <div class="text-center mb-16">
        <div class="w-20 h-20 bg-teal-800 rounded-full flex items-center justify-center mx-auto mb-6">
          <span class="text-white font-bold text-3xl">{{ brandInitial }}</span>
        </div>
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-6">
          About {{ BRAND_NAME }}
        </h1>
        <p class="text-xl text-gray-600 max-w-3xl mx-auto leading-relaxed">
          We believe that everyone deserves to feel confident and prepared when emergencies happen. 
          {{ BRAND_NAME }} makes first aid education accessible, engaging, and empowering for everyone.
        </p>
      </div>

      <!-- Mission & Vision -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 mb-16">
        <div class="bg-white rounded-xl shadow-lg p-8">
          <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">🎯</span>
          </div>
          <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">Our Mission</h2>
          <p class="text-gray-700 leading-relaxed">
            To overcome public apathy about first aid by providing clear, accessible, and free education 
            that builds confidence and competence. We transform fear and uncertainty into knowledge and action.
          </p>
        </div>

        <div class="bg-white rounded-xl shadow-lg p-8">
          <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mb-4">
            <span class="text-2xl">🌟</span>
          </div>
          <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">Our Vision</h2>
          <p class="text-gray-700 leading-relaxed">
            A world where every person, regardless of their background or income, feels confident and empowered to take life-saving action in a medical emergency. Where "I don't know what to do" becomes "I know exactly how to help."
          </p>
        </div>
      </div>

      <!-- Core Values -->
      <div class="bg-white rounded-xl shadow-lg p-8 mb-16">
        <h2 class="text-3xl font-heading font-bold text-teal-800 mb-8 text-center">
          What Drives Us
        </h2>
        
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="text-center">
            <div class="w-16 h-16 bg-teal-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <span class="text-3xl">🤝</span>
            </div>
            <h3 class="text-xl font-heading font-bold text-teal-800 mb-3">Accessibility</h3>
            <p class="text-gray-600">
              First aid education should be free and available to everyone, regardless of background or circumstances.
            </p>
          </div>

          <div class="text-center">
            <div class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <span class="text-3xl">💪</span>
            </div>
            <h3 class="text-xl font-heading font-bold text-teal-800 mb-3">Empowerment</h3>
            <p class="text-gray-600">
              We build confidence through clear, practical training that prepares people to act when it matters most.
            </p>
          </div>

          <div class="text-center">
            <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
              <span class="text-3xl">🎯</span>
            </div>
            <h3 class="text-xl font-heading font-bold text-teal-800 mb-3">Clarity</h3>
            <p class="text-gray-600">
              Complex medical procedures simplified into clear, memorable steps that anyone can follow.
            </p>
          </div>
        </div>
      </div>

      <!-- The Problem We Solve -->
      <div class="bg-gradient-to-r from-teal-800 to-teal-600 rounded-xl p-8 text-white mb-16">
        <h2 class="text-3xl font-heading font-bold mb-6 text-center">
          Why {{ BRAND_NAME }} Exists
        </h2>
        
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div>
            <h3 class="text-xl font-semibold mb-4 text-yellow-400">The Challenge</h3>
            <ul class="space-y-3 text-gray-100">
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Most people feel helpless in medical emergencies
              </li>
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Traditional first aid courses are expensive and time-consuming
              </li>
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Fear of "doing it wrong\" prevents people from helping
              </li>
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Critical minutes are lost while waiting for professional help
              </li>
            </ul>
          </div>

          <div>
            <h3 class="text-xl font-semibold mb-4 text-yellow-400">Our Solution</h3>
            <ul class="space-y-3 text-gray-100">
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Free, accessible online learning modules
              </li>
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Bite-sized lessons that fit into busy schedules
              </li>
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Clear, confidence-building instruction
              </li>
              <li class="flex items-start">
                <span class="text-yellow-400 mr-2">•</span>
                Achievement system that motivates continued learning
              </li>
            </ul>
          </div>
        </div>
      </div>

      <!-- Our Approach -->
      <div class="bg-white rounded-xl shadow-lg p-8 mb-16">
        <h2 class="text-3xl font-heading font-bold text-teal-800 mb-8 text-center">
          How We're Different
        </h2>

        <div class="space-y-8">
          <div class="flex items-start">
            <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
              <span class="text-2xl">🧠</span>
            </div>
            <div>
              <h3 class="text-xl font-heading font-bold text-teal-800 mb-2">Psychology-Based Learning</h3>
              <p class="text-gray-700">
                We understand that fear and panic are the biggest barriers to effective first aid. 
                Our approach builds confidence through repetition, positive reinforcement, and real-world scenarios.
              </p>
            </div>
          </div>

          <div class="flex items-start">
            <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
              <span class="text-2xl">📱</span>
            </div>
            <div>
              <h3 class="text-xl font-heading font-bold text-teal-800 mb-2">Mobile-First Design</h3>
              <p class="text-gray-700">
                Learn anywhere, anytime. Our platform works perfectly on phones, tablets, and computers, 
                making it easy to fit learning into your daily routine.
              </p>
            </div>
          </div>

          <div class="flex items-start">
            <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
              <span class="text-2xl">🏆</span>
            </div>
            <div>
              <h3 class="text-xl font-heading font-bold text-teal-800 mb-2">Achievement & Community</h3>
              <p class="text-gray-700">
                Earn badges, share achievements, and connect with others who are building life-saving skills. 
                Learning is more effective and enjoyable when it's social.
              </p>
            </div>
          </div>

          <div class="flex items-start">
            <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mr-4 flex-shrink-0">
              <span class="text-2xl">🎯</span>
            </div>
            <div>
              <h3 class="text-xl font-heading font-bold text-teal-800 mb-2">Practical Focus</h3>
              <p class="text-gray-700">
                We focus on the most common emergencies and the most effective responses. 
                No overwhelming medical jargon - just clear, actionable steps that work.
              </p>
            </div>
          </div>
        </div>
      </div>

      <!-- Impact -->
      <div class="bg-yellow-50 rounded-xl border-2 border-yellow-200 p-8 mb-16">
        <h2 class="text-3xl font-heading font-bold text-teal-800 mb-6 text-center">
          Our Growing Impact
        </h2>
        
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6 text-center">
          <div>
            <div class="text-4xl font-bold text-teal-800 mb-2">1000+</div>
            <div class="text-gray-600">Learners Trained</div>
          </div>
          <div>
            <div class="text-4xl font-bold text-teal-800 mb-2">2,500+</div>
            <div class="text-gray-600">Badges Earned</div>
          </div>
          <div>
            <div class="text-4xl font-bold text-teal-800 mb-2">150+</div>
            <div class="text-gray-600">Success Stories</div>
          </div>
          <div>
            <div class="text-4xl font-bold text-teal-800 mb-2">100%</div>
            <div class="text-gray-600">Free Forever</div>
          </div>
        </div>
      </div>

      <!-- Call to Action -->
      <div class="text-center">
        <h2 class="text-3xl font-heading font-bold text-teal-800 mb-4">
          Ready to Be the Help?
        </h2>
        <p class="text-lg text-gray-600 mb-8 max-w-2xl mx-auto">
          Join thousands of people who are building confidence and life-saving skills. 
          Your first lesson takes just 10 minutes.
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <router-link
            to="/register"
            class="bg-yellow-400 text-teal-800 px-8 py-4 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
          >
            Start Learning Today
          </router-link>
          <router-link
            to="/learn"
            class="bg-teal-800 text-white px-8 py-4 rounded-lg text-lg font-bold hover:bg-teal-700 transition-colors duration-200"
          >
            Browse Modules
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { BRAND_NAME } from '../lib/config'

const brandInitial = BRAND_NAME.charAt(0)
</script>