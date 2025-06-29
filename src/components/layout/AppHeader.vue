<template>
  <header class="bg-white shadow-sm border-b border-gray-200">
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between items-center h-16">
        <!-- Logo -->
        <div class="flex items-center">
          <router-link to="/" class="flex items-center space-x-2">
            <img 
              src="/logo.png" 
              alt="{{ BRAND_NAME }} Logo" 
              class="w-16 h-16 object-contain"
            />
            <span class="text-xl font-heading font-bold text-teal-800">{{ BRAND_NAME }}</span>
          </router-link>
        </div>

        <!-- Desktop Navigation -->
        <div class="hidden md:flex items-center space-x-8">
          <router-link
            v-for="link in navigationLinks"
            :key="link.name"
            :to="link.path"
            class="text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
            active-class="text-teal-800 font-semibold"
          >
            {{ link.name }}
          </router-link>
        </div>

        <!-- User Menu / Auth -->
        <div class="hidden md:flex items-center space-x-4">
          <div v-if="isAuthenticated" class="flex items-center space-x-4">
            <router-link
              to="/dashboard"
              class="text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
            >
              Dashboard
            </router-link>
            <button
              @click="handleSignOut"
              class="text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
            >
              Sign Out
            </button>
          </div>
          <div v-else class="flex items-center space-x-4">
            <router-link
              to="/login"
              class="text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
            >
              Sign In
            </router-link>
            <router-link
              to="/register"
              class="bg-yellow-400 text-teal-800 px-4 py-2 rounded-lg font-semibold hover:bg-yellow-300 transition-colors duration-200"
            >
              Get Started
            </router-link>
          </div>
        </div>

        <!-- Mobile menu button -->
        <div class="md:hidden">
          <button
            @click="mobileMenuOpen = !mobileMenuOpen"
            class="text-gray-700 hover:text-teal-800 focus:outline-none focus:text-teal-800"
          >
            <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path
                v-if="!mobileMenuOpen"
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M4 6h16M4 12h16M4 18h16"
              />
              <path
                v-else
                stroke-linecap="round"
                stroke-linejoin="round"
                stroke-width="2"
                d="M6 18L18 6M6 6l12 12"
              />
            </svg>
          </button>
        </div>
      </div>

      <!-- Mobile menu -->
      <div v-if="mobileMenuOpen" class="md:hidden">
        <div class="px-2 pt-2 pb-3 space-y-1 bg-gray-50 rounded-lg mt-2">
          <router-link
            v-for="link in navigationLinks"
            :key="link.name"
            :to="link.path"
            class="block px-3 py-2 text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
            active-class="text-teal-800 font-semibold"
            @click="mobileMenuOpen = false"
          >
            {{ link.name }}
          </router-link>
          
          <div v-if="isAuthenticated" class="border-t border-gray-200 pt-2">
            <router-link
              to="/dashboard"
              class="block px-3 py-2 text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
              @click="mobileMenuOpen = false"
            >
              Dashboard
            </router-link>
            <button
              @click="handleSignOut"
              class="block w-full text-left px-3 py-2 text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
            >
              Sign Out
            </button>
          </div>
          <div v-else class="border-t border-gray-200 pt-2">
            <router-link
              to="/login"
              class="block px-3 py-2 text-gray-700 hover:text-teal-800 font-medium transition-colors duration-200"
              @click="mobileMenuOpen = false"
            >
              Sign In
            </router-link>
            <router-link
              to="/register"
              class="block mx-3 my-2 bg-yellow-400 text-teal-800 px-4 py-2 rounded-lg font-semibold hover:bg-yellow-300 transition-colors duration-200 text-center"
              @click="mobileMenuOpen = false"
            >
              Get Started
            </router-link>
          </div>
        </div>
      </div>
    </nav>
  </header>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { useAuth } from '../../stores/auth'
import { BRAND_NAME } from '../../lib/config'

const router = useRouter()
const { isAuthenticated, signOut } = useAuth()
const mobileMenuOpen = ref(false)

const navigationLinks = [
  { name: 'Learn', path: '/learn' },
  { name: 'Real Stories', path: '/stories' },
  { name: 'About', path: '/about' },
  { name: 'Donate', path: '/donate' }
]

const handleSignOut = async () => {
  await signOut()
  mobileMenuOpen.value = false
  router.push('/')
}
</script>