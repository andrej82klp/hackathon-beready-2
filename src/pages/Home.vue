<template>
  <div>
    <!-- Hero Section -->
    <section class="relative bg-gradient-to-br from-teal-800 to-teal-600 text-white">
      <div class="absolute inset-0 bg-black opacity-20"></div>
      <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-20 lg:py-32">
        <div class="text-center">
          <h1 class="text-4xl md:text-6xl font-heading font-bold mb-6 leading-tight">
            You are the help<br>
            <span class="text-yellow-400">until help arrives</span>
          </h1>
          <p class="text-xl md:text-2xl mb-8 text-gray-100 max-w-3xl mx-auto">
            Gain the confidence and skills to act in an emergency that could save a life - starting with just 10 minutes today. Our clear,       simple guides are free for everyone.
          </p>
          <router-link
            to="/learn"
            class="inline-block bg-yellow-400 text-teal-800 px-8 py-4 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-1"
          >
            Start Learning Now
          </router-link>
        </div>
      </div>
    </section>

    <!-- Learning Modules Section -->
    <section class="py-16 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-heading font-bold text-teal-800 mb-4">
            Start with the Basics
          </h2>
          <p class="text-lg text-gray-600 max-w-2xl mx-auto">
            Master essential first aid skills through our carefully designed learning modules. 
            Each takes just 10-15 minutes and earns you a badge.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div
            v-for="module in featuredModules"
            :key="module.id"
            class="bg-white rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-2 border border-gray-100"
          >
            <div class="p-6">
              <div class="w-12 h-12 bg-yellow-100 rounded-lg flex items-center justify-center mb-4">
                <span class="text-2xl">{{ module.icon }}</span>
              </div>
              <h3 class="text-xl font-heading font-bold text-teal-800 mb-2">
                {{ module.title }}
              </h3>
              <p class="text-gray-600 mb-4">
                {{ module.description }}
              </p>
              <div class="flex items-center justify-between">
                <span class="text-sm text-gray-500">{{ module.duration }}</span>
                <router-link
                  :to="`/learn/${module.id}`"
                  class="bg-teal-800 text-white px-4 py-2 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200 inline-block"
                >
                  Start Module
                </router-link>
              </div>
            </div>
          </div>
        </div>

        <div class="text-center mt-12">
          <router-link
            to="/learn"
            class="inline-block bg-gray-100 text-teal-800 px-8 py-3 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-200"
          >
            View All Modules
          </router-link>
        </div>
      </div>
    </section>

    <!-- Interactive Scenario Section -->
    <section class="py-16 bg-gray-50">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="bg-yellow-50 rounded-2xl p-8 lg:p-12 border-2 border-yellow-200">
          <div class="text-center">
            <div class="w-16 h-16 bg-yellow-400 rounded-full flex items-center justify-center mx-auto mb-6">
              <span class="text-3xl">🤔</span>
            </div>
            <h2 class="text-3xl md:text-4xl font-heading font-bold text-teal-800 mb-4">
              What Would You Do?
            </h2>
            <p class="text-lg text-gray-700 mb-8 max-w-2xl mx-auto">
              Test your knowledge with real-life scenarios. These quick quizzes help you think through 
              emergency situations and build confidence in your response.
            </p>
            <button
              @click="startScenario"
              class="bg-yellow-400 text-teal-800 px-8 py-4 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200 shadow-lg"
            >
              Try a Scenario
            </button>
          </div>
        </div>
      </div>
    </section>

    <!-- Real Stories Section -->
    <section class="py-16 bg-white">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="text-center mb-12">
          <h2 class="text-3xl md:text-4xl font-heading font-bold text-teal-800 mb-4">
            Real Stories from Real People
          </h2>
          <p class="text-lg text-gray-600 max-w-2xl mx-auto">
            Discover how ordinary people used their first aid knowledge to make a difference 
            when it mattered most.
          </p>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div
            v-for="story in featuredStories"
            :key="story.id"
            class="bg-gray-50 rounded-xl p-6 border border-gray-200"
          >
            <div class="flex items-center mb-4">
              <div class="w-12 h-12 bg-teal-100 rounded-full flex items-center justify-center">
                <span class="text-teal-800 font-bold text-lg">{{ story.name.charAt(0) }}</span>
              </div>
              <div class="ml-3">
                <h3 class="font-semibold text-teal-800">{{ story.name }}</h3>
                <p class="text-sm text-gray-500">{{ story.location }}</p>
              </div>
            </div>
            <blockquote class="text-gray-700 italic">
              "{{ story.story }}"
            </blockquote>
          </div>
        </div>

        <div class="text-center mt-12">
          <router-link
            to="/stories"
            class="inline-block bg-teal-800 text-white px-8 py-3 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200 mr-4"
          >
            Read More Stories
          </router-link>
          <router-link
            to="/stories"
            class="inline-block bg-gray-100 text-teal-800 px-8 py-3 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-200"
          >
            Share Your Story
          </router-link>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="py-16 bg-teal-800 text-white">
      <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h2 class="text-3xl md:text-4xl font-heading font-bold mb-4">
          Ready to Make a Difference?
        </h2>
        <p class="text-xl mb-8 text-gray-100">
          Join thousands of people who are building confidence and life-saving skills. 
          Your first lesson takes just 10 minutes.
        </p>
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <router-link
            to="/register"
            class="bg-yellow-400 text-teal-800 px-8 py-4 rounded-lg text-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
          >
            Create Free Account
          </router-link>
          <router-link
            to="/learn"
            class="bg-transparent border-2 border-white text-white px-8 py-4 rounded-lg text-lg font-bold hover:bg-white hover:text-teal-800 transition-colors duration-200"
          >
            Browse Lessons
          </router-link>
        </div>
      </div>
    </section>

    <!-- Scenario Modal -->
    <div
      v-if="showScenarioModal"
      class="fixed inset-0 z-50 overflow-y-auto bg-black bg-opacity-50 flex items-center justify-center p-4"
    >
      <div class="bg-white rounded-xl shadow-2xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
        <div class="p-8">
          <div class="flex items-center justify-between mb-6">
            <h3 class="text-2xl font-heading font-bold text-teal-800">
              Emergency Scenario
            </h3>
            <button
              @click="closeScenario"
              class="text-gray-400 hover:text-gray-600"
            >
              <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </button>
          </div>

          <div v-if="!scenarioAnswered" class="mb-8">
            <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-6 mb-6">
              <h4 class="text-lg font-semibold text-teal-800 mb-3">
                {{ currentScenario.title }}
              </h4>
              <p class="text-gray-700">
                {{ currentScenario.description }}
              </p>
            </div>

            <h5 class="text-lg font-semibold text-gray-800 mb-4">
              What should you do first?
            </h5>
            
            <div class="space-y-3">
              <button
                v-for="(option, index) in currentScenario.options"
                :key="index"
                @click="selectScenarioAnswer(index)"
                class="w-full text-left p-4 rounded-lg border-2 border-gray-200 hover:border-teal-200 hover:bg-teal-50 transition-all duration-200"
              >
                {{ option.text }}
              </button>
            </div>
          </div>

          <div v-else class="text-center">
            <div class="w-16 h-16 rounded-full flex items-center justify-center mx-auto mb-4"
                 :class="scenarioCorrect ? 'bg-green-100' : 'bg-yellow-100'">
              <span class="text-3xl">{{ scenarioCorrect ? '✅' : '💡' }}</span>
            </div>
            
            <h4 class="text-xl font-heading font-bold text-teal-800 mb-4">
              {{ scenarioCorrect ? 'Excellent!' : 'Good thinking!' }}
            </h4>
            
            <div class="bg-gray-50 rounded-lg p-6 mb-6 text-left">
              <h5 class="font-semibold text-gray-800 mb-2">Explanation:</h5>
              <p class="text-gray-700">{{ currentScenario.explanation }}</p>
            </div>

            <div class="flex flex-col sm:flex-row gap-3">
              <button
                @click="tryAnotherScenario"
                class="flex-1 bg-yellow-400 text-teal-800 px-6 py-3 rounded-lg font-bold hover:bg-yellow-300 transition-colors duration-200"
              >
                Try Another Scenario
              </button>
              <router-link
                to="/learn"
                class="flex-1 bg-teal-800 text-white px-6 py-3 rounded-lg font-bold hover:bg-teal-700 transition-colors duration-200 text-center"
                @click="closeScenario"
              >
                Start Learning
              </router-link>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useModules } from '../stores/modules'
import { useStories } from '../stores/stories'

const { modules, fetchModules } = useModules()
const { featuredStories, fetchFeaturedStories } = useStories()

const featuredModules = ref<any[]>([])
const showScenarioModal = ref(false)
const scenarioAnswered = ref(false)
const scenarioCorrect = ref(false)

const scenarios = [
  {
    title: "Choking Emergency",
    description: "You're at a restaurant when you notice an elderly man at the next table suddenly standing up, clutching his throat, and unable to speak. His face is turning red and he appears to be in distress.",
    options: [
      { text: "Call 911 immediately", correct: false },
      { text: "Ask if he's choking and perform the Heimlich maneuver", correct: true },
      { text: "Give him water to drink", correct: false },
      { text: "Tell him to cough harder", correct: false }
    ],
    explanation: "When someone is choking and cannot speak or breathe, immediate action is needed. The Heimlich maneuver (abdominal thrusts) should be performed right away to dislodge the obstruction. Calling 911 is important but shouldn't delay immediate intervention."
  },
  {
    title: "Unconscious Person",
    description: "While walking in the park, you find someone lying unconscious on the ground. They appear to be breathing but are completely unresponsive to your voice and gentle shaking.",
    options: [
      { text: "Move them to a more comfortable position", correct: false },
      { text: "Check for dangers, call 911, and monitor their breathing", correct: true },
      { text: "Try to wake them up by shaking them harder", correct: false },
      { text: "Give them something to drink", correct: false }
    ],
    explanation: "First, ensure the scene is safe for both you and the victim. Call 911 immediately for an unconscious person. Monitor their breathing and be prepared to start CPR if breathing stops. Never move someone unless they're in immediate danger, as they may have spinal injuries."
  }
]

const currentScenario = ref(scenarios[0])

onMounted(async () => {
  await fetchModules()
  await fetchFeaturedStories()
  
  // Get first 3 modules as featured
  featuredModules.value = modules.value.slice(0, 3)
})

const startScenario = () => {
  // Randomly select a scenario
  currentScenario.value = scenarios[Math.floor(Math.random() * scenarios.length)]
  showScenarioModal.value = true
  scenarioAnswered.value = false
  scenarioCorrect.value = false
}

const closeScenario = () => {
  showScenarioModal.value = false
}

const selectScenarioAnswer = (index: number) => {
  scenarioCorrect.value = currentScenario.value.options[index].correct
  scenarioAnswered.value = true
}

const tryAnotherScenario = () => {
  // Select a different scenario
  const otherScenarios = scenarios.filter(s => s !== currentScenario.value)
  currentScenario.value = otherScenarios[Math.floor(Math.random() * otherScenarios.length)]
  scenarioAnswered.value = false
  scenarioCorrect.value = false
}
</script>