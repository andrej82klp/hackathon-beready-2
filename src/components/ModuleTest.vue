<template>
  <div class="module-test">
    <!-- Authentication Check -->
    <div v-if="!isAuthenticated" class="text-center py-8">
      <div class="w-16 h-16 bg-blue-100 rounded-full flex items-center justify-center mx-auto mb-4">
        <span class="text-3xl">🔐</span>
      </div>
      <h3 class="text-xl font-heading font-bold text-gray-800 mb-2">Sign In Required</h3>
      <p class="text-gray-600 mb-4">You must be signed in to take tests and earn badges.</p>
      <div class="flex flex-col sm:flex-row gap-3 justify-center">
        <router-link
          to="/login"
          class="bg-teal-800 text-white px-6 py-2 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200"
        >
          Sign In
        </router-link>
        <router-link
          to="/register"
          class="bg-yellow-400 text-teal-800 px-6 py-2 rounded-lg font-semibold hover:bg-yellow-300 transition-colors duration-200"
        >
          Create Account
        </router-link>
      </div>
    </div>

    <!-- Loading State -->
    <div v-else-if="loading" class="text-center py-8">
      <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-teal-800"></div>
      <p class="mt-4 text-gray-600">Loading test...</p>
    </div>

    <!-- Error State -->
    <div v-else-if="error" class="text-center py-8">
      <div class="w-16 h-16 bg-red-100 rounded-full flex items-center justify-center mx-auto mb-4">
        <span class="text-3xl">❌</span>
      </div>
      <h3 class="text-xl font-heading font-bold text-gray-800 mb-2">Test Not Available</h3>
      <p class="text-gray-600 mb-4">{{ error }}</p>
      <button
        @click="$emit('close')"
        class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg font-semibold hover:bg-gray-300 transition-colors duration-200"
      >
        Close
      </button>
    </div>

    <!-- Test Content -->
    <div v-else-if="isAuthenticated && test && questions.length > 0">
      <!-- Test Header -->
      <div class="flex items-center justify-between mb-6">
        <h3 class="text-2xl font-heading font-bold text-teal-800">
          {{ moduleName }} Assessment
        </h3>
        <button
          @click="$emit('close')"
          class="text-gray-400 hover:text-gray-600"
        >
          <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
          </svg>
        </button>
      </div>

      <!-- Test Description -->
      <div v-if="test.description" class="mb-6">
        <p class="text-gray-600">{{ test.description }}</p>
      </div>

      <!-- Progress Bar -->
      <div class="mb-6">
        <div class="flex justify-between text-sm text-gray-600 mb-2">
          <span v-if="currentQuestion < questions.length">Question {{ currentQuestion + 1 }} of {{ questions.length }}</span>
          <span v-else></span>
          <span>{{ currentQuestion >= questions.length ? '100' : Math.round(((currentQuestion + 1) / questions.length) * 100) }}%</span>
        </div>
        <div class="w-full bg-gray-200 rounded-full h-2">
          <div
            class="bg-yellow-400 h-2 rounded-full transition-all duration-300"
            :style="{ width: currentQuestion >= questions.length ? '100%' : ((currentQuestion + 1) / questions.length) * 100 + '%' }"
          ></div>
        </div>
      </div>

      <!-- Question -->
      <div v-if="currentQuestion < questions.length" class="mb-8">
        <h4 class="text-xl font-semibold text-gray-800 mb-6">
          {{ questions[currentQuestion].question_text }}
        </h4>
        
        <div class="space-y-3">
          <button
            v-for="(option, index) in questions[currentQuestion].options"
            :key="index"
            @click="selectAnswer(index)"
            class="w-full text-left p-4 rounded-lg border-2 transition-all duration-200"
            :class="selectedAnswer === index 
              ? 'border-teal-800 bg-teal-50 text-teal-800' 
              : 'border-gray-200 hover:border-gray-300 bg-white'"
          >
            {{ option.text }}
          </button>
        </div>
      </div>

      <!-- Test Complete -->
      <div v-else class="text-center">
        <div class="w-16 h-16 bg-green-100 rounded-full flex items-center justify-center mx-auto mb-4">
          <span class="text-3xl">✅</span>
        </div>
        <h4 class="text-2xl font-heading font-bold text-teal-800 mb-4">
          Assessment Complete!
        </h4>
        <p class="text-gray-700 mb-6">
          Your score: {{ testScore }}%
        </p>
        <div v-if="testScore >= 70" class="bg-green-50 border border-green-200 rounded-lg p-4 mb-4">
          <p class="text-green-800 font-semibold">
            🎉 Congratulations! You've earned your {{ badgeName }} badge!
          </p>
        </div>
        <div v-else class="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-4">
          <p class="text-yellow-800">
            You need 70% or higher to earn your badge. Review the material and try again!
          </p>
        </div>
      </div>

      <!-- Navigation -->
      <div class="flex justify-between">
        <button
          v-if="currentQuestion > 0 && currentQuestion < questions.length"
          @click="previousQuestion"
          class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg font-semibold hover:bg-gray-300 transition-colors duration-200"
        >
          Previous
        </button>
        <div v-else></div>

        <button
          v-if="currentQuestion < questions.length - 1 && selectedAnswer !== null"
          @click="nextQuestion"
          class="bg-teal-800 text-white px-6 py-2 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200"
        >
          Next Question
        </button>
        <button
          v-else-if="currentQuestion === questions.length - 1 && selectedAnswer !== null"
          @click="finishTest"
          :disabled="submittingTest"
          class="bg-yellow-400 text-teal-800 px-6 py-2 rounded-lg font-semibold hover:bg-yellow-300 transition-colors duration-200 disabled:opacity-50"
        >
          {{ submittingTest ? 'Submitting...' : 'Finish Test' }}
        </button>
        <button
          v-else-if="currentQuestion >= questions.length"
          @click="$emit('close')"
          class="bg-teal-800 text-white px-6 py-2 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200"
        >
          Continue Learning
        </button>
      </div>
    </div>

    <!-- No Test Available -->
    <div v-else-if="isAuthenticated" class="text-center py-8">
      <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
        <span class="text-3xl">📝</span>
      </div>
      <h3 class="text-xl font-heading font-bold text-gray-800 mb-2">No Test Available</h3>
      <p class="text-gray-600 mb-4">This module doesn't have a test yet.</p>
      <button
        @click="$emit('close')"
        class="bg-gray-200 text-gray-700 px-6 py-2 rounded-lg font-semibold hover:bg-gray-300 transition-colors duration-200"
      >
        Close
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { useAuth } from '../stores/auth'
import { testService } from '../lib/supabase'
import type { Test, Question } from '../lib/supabase'

interface Props {
  moduleId: string
  moduleName: string
  badgeName: string
}

const props = defineProps<Props>()
const { isAuthenticated } = useAuth()

const emit = defineEmits<{
  'test-completed': [score: number, moduleId: string]
  'close': []
}>()

const test = ref<Test | null>(null)
const questions = ref<Question[]>([])
const loading = ref(true)
const error = ref<string | null>(null)

const currentQuestion = ref(0)
const selectedAnswer = ref<number | null>(null)
const userAnswers = ref<number[]>([])
const testScore = ref(0)
const submittingTest = ref(false)

const selectAnswer = (index: number) => {
  selectedAnswer.value = index
}

const nextQuestion = () => {
  if (selectedAnswer.value !== null) {
    userAnswers.value[currentQuestion.value] = selectedAnswer.value
    currentQuestion.value++
    selectedAnswer.value = userAnswers.value[currentQuestion.value] || null
  }
}

const previousQuestion = () => {
  if (currentQuestion.value > 0) {
    currentQuestion.value--
    selectedAnswer.value = userAnswers.value[currentQuestion.value] || null
  }
}

const finishTest = async () => {
  if (selectedAnswer.value !== null) {
    userAnswers.value[currentQuestion.value] = selectedAnswer.value
  }

  submittingTest.value = true

  try {
    // Calculate score
    let correct = 0
    userAnswers.value.forEach((answerIndex, questionIndex) => {
      const question = questions.value[questionIndex]
      if (question && question.options[answerIndex]?.is_correct) {
        correct++
      }
    })
    
    testScore.value = Math.round((correct / questions.value.length) * 100)
    currentQuestion.value = questions.value.length

    // Emit test completion event
    emit('test-completed', testScore.value, props.moduleId)
  } catch (error) {
    console.error('Error calculating test score:', error)
  } finally {
    submittingTest.value = false
  }
}

onMounted(async () => {
  // Only load test if user is authenticated
  if (!isAuthenticated.value) {
    loading.value = false
    return
  }
  
  loading.value = true
  error.value = null

  try {
    // Fetch test for this module
    const { data: testData, error: testError } = await testService.getTestByModuleId(props.moduleId)
    
    if (testError) {
      throw new Error('Failed to load test: ' + testError.message)
    }

    if (!testData) {
      error.value = 'No test found for this module'
      return
    }

    test.value = testData

    // Fetch questions for this test
    const { data: questionsData, error: questionsError } = await testService.getQuestionsByTestId(testData.id)
    
    if (questionsError) {
      throw new Error('Failed to load questions: ' + questionsError.message)
    }

    questions.value = questionsData || []

    if (questions.value.length === 0) {
      error.value = 'No questions found for this test'
    }
  } catch (err) {
    console.error('Error loading test:', err)
    error.value = err instanceof Error ? err.message : 'Failed to load test'
  } finally {
    loading.value = false
  }
})
</script>