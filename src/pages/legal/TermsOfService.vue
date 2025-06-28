<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="text-center mb-12">
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          Terms of Service
        </h1>
        <p class="text-lg text-gray-600">
          Last updated: {{ lastUpdated }}
        </p>
      </div>

      <!-- Content -->
      <div class="bg-white rounded-xl shadow-lg p-8 md:p-12">
        <div class="prose prose-lg max-w-none">
          <!-- Introduction -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">1. Introduction</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              Welcome to {{ BRAND_NAME }} ("we," "our," or "us"). These Terms of Service ("Terms") govern your use of our website located at {{ BRAND_WEBSITE }} (the "Service") operated by {{ BRAND_NAME }}.
            </p>
            <p class="text-gray-700 leading-relaxed">
              By accessing or using our Service, you agree to be bound by these Terms. If you disagree with any part of these terms, then you may not access the Service.
            </p>
          </section>

          <!-- Acceptance of Terms -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">2. Acceptance of Terms</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              By creating an account or using {{ BRAND_NAME }}, you acknowledge that you have read, understood, and agree to be bound by these Terms and our Privacy Policy.
            </p>
            <p class="text-gray-700 leading-relaxed">
              We reserve the right to modify these Terms at any time. We will notify users of any material changes via email or through our Service. Your continued use of the Service after such modifications constitutes acceptance of the updated Terms.
            </p>
          </section>

          <!-- Description of Service -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">3. Description of Service</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              {{ BRAND_NAME }} is an educational platform that provides free first aid training modules, assessments, and resources. Our Service includes:
            </p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Interactive learning modules on first aid techniques</li>
              <li>Knowledge assessments and achievement badges</li>
              <li>User progress tracking and achievement sharing</li>
              <li>Community features for sharing experiences</li>
              <li>Educational resources and emergency preparedness information</li>
            </ul>
            <div class="bg-red-50 border-l-4 border-red-400 p-4 mb-4">
              <p class="text-red-800 font-semibold">
                <strong>Important:</strong> {{ BRAND_NAME }} provides educational content only. Our Service is not a substitute for professional medical training, advice, diagnosis, or treatment. Always seek the advice of qualified healthcare providers for medical emergencies and professional first aid certification.
              </p>
            </div>
          </section>

          <!-- User Accounts -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">4. User Accounts</h2>
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Account Creation</h3>
            <p class="text-gray-700 leading-relaxed mb-4">
              To access certain features of our Service, you must create an account. You agree to provide accurate, current, and complete information during registration and to update such information to keep it accurate, current, and complete.
            </p>
            
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Account Security</h3>
            <p class="text-gray-700 leading-relaxed mb-4">
              You are responsible for safeguarding your account credentials and for all activities that occur under your account. You agree to notify us immediately of any unauthorized use of your account.
            </p>
            
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Account Termination</h3>
            <p class="text-gray-700 leading-relaxed">
              We may terminate or suspend your account at any time for violations of these Terms or for any other reason at our sole discretion.
            </p>
          </section>

          <!-- User Content -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">5. User Content</h2>
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Content Submission</h3>
            <p class="text-gray-700 leading-relaxed mb-4">
              Our Service may allow you to submit, upload, or share content, including stories, feedback, and comments ("User Content"). You retain ownership of your User Content, but you grant us a worldwide, non-exclusive, royalty-free license to use, display, and distribute your User Content in connection with the Service.
            </p>
            
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Content Standards</h3>
            <p class="text-gray-700 leading-relaxed mb-4">You agree that your User Content will not:</p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Violate any applicable laws or regulations</li>
              <li>Infringe on the rights of others</li>
              <li>Contain false, misleading, or harmful information</li>
              <li>Include spam, advertising, or promotional content</li>
              <li>Contain offensive, abusive, or inappropriate material</li>
              <li>Provide medical advice or claim to replace professional medical care</li>
            </ul>
            
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Content Moderation</h3>
            <p class="text-gray-700 leading-relaxed">
              We reserve the right to review, edit, or remove any User Content at our sole discretion, including content that violates these Terms or our community standards.
            </p>
          </section>

          <!-- Prohibited Uses -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">6. Prohibited Uses</h2>
            <p class="text-gray-700 leading-relaxed mb-4">You may not use our Service:</p>
            <ul class="list-disc list-inside text-gray-700 space-y-2">
              <li>For any unlawful purpose or to solicit others to perform unlawful acts</li>
              <li>To violate any international, federal, provincial, or state regulations, rules, laws, or local ordinances</li>
              <li>To infringe upon or violate our intellectual property rights or the intellectual property rights of others</li>
              <li>To harass, abuse, insult, harm, defame, slander, disparage, intimidate, or discriminate</li>
              <li>To submit false or misleading information</li>
              <li>To upload or transmit viruses or any other type of malicious code</li>
              <li>To spam, phish, pharm, pretext, spider, crawl, or scrape</li>
              <li>For any obscene or immoral purpose</li>
              <li>To interfere with or circumvent the security features of the Service</li>
            </ul>
          </section>

          <!-- Intellectual Property -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">7. Intellectual Property Rights</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              The Service and its original content, features, and functionality are and will remain the exclusive property of {{ BRAND_NAME }} and its licensors. The Service is protected by copyright, trademark, and other laws. Our trademarks and trade dress may not be used in connection with any product or service without our prior written consent.
            </p>
            <p class="text-gray-700 leading-relaxed">
              All educational content, including but not limited to text, graphics, logos, images, and software, is the property of {{ BRAND_NAME }} or its content suppliers and is protected by intellectual property laws.
            </p>
          </section>

          <!-- Medical Disclaimer -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">8. Medical Disclaimer</h2>
            <div class="bg-red-50 border-2 border-red-200 rounded-lg p-6">
              <p class="text-red-800 font-semibold mb-4">
                <strong>IMPORTANT MEDICAL DISCLAIMER</strong>
              </p>
              <p class="text-red-700 leading-relaxed mb-4">
                The information provided through {{ BRAND_NAME }} is for educational purposes only and is not intended to be a substitute for professional medical advice, diagnosis, or treatment. Always seek the advice of your physician or other qualified health provider with any questions you may have regarding a medical condition or emergency.
              </p>
              <p class="text-red-700 leading-relaxed mb-4">
                Never disregard professional medical advice or delay in seeking it because of something you have learned through our Service. If you think you may have a medical emergency, call your doctor or emergency services immediately.
              </p>
              <p class="text-red-700 leading-relaxed">
                {{ BRAND_NAME }} does not recommend or endorse any specific tests, physicians, products, procedures, opinions, or other information that may be mentioned on the Service.
              </p>
            </div>
          </section>

          <!-- Disclaimers -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">9. Disclaimers</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              The information on this Service is provided on an "as is" basis. To the fullest extent permitted by law, {{ BRAND_NAME }} excludes all representations, warranties, conditions, and terms whether express, implied, or statutory.
            </p>
            <p class="text-gray-700 leading-relaxed">
              {{ BRAND_NAME }} makes no warranty that the Service will meet your requirements, be available on an uninterrupted, timely, secure, or error-free basis, or that any defects will be corrected.
            </p>
          </section>

          <!-- Limitation of Liability -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">10. Limitation of Liability</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              In no event shall {{ BRAND_NAME }}, its directors, employees, partners, agents, suppliers, or affiliates be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses, resulting from your use of the Service.
            </p>
            <p class="text-gray-700 leading-relaxed">
              Our total liability to you for all claims arising from or relating to the Service shall not exceed the amount you paid us in the twelve (12) months preceding the claim.
            </p>
          </section>

          <!-- Indemnification -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">11. Indemnification</h2>
            <p class="text-gray-700 leading-relaxed">
              You agree to defend, indemnify, and hold harmless {{ BRAND_NAME }} and its licensee and licensors, and their employees, contractors, agents, officers and directors, from and against any and all claims, damages, obligations, losses, liabilities, costs or debt, and expenses (including but not limited to attorney's fees).
            </p>
          </section>

          <!-- Termination -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">12. Termination</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              We may terminate or suspend your account and bar access to the Service immediately, without prior notice or liability, under our sole discretion, for any reason whatsoever and without limitation, including but not limited to a breach of the Terms.
            </p>
            <p class="text-gray-700 leading-relaxed">
              If you wish to terminate your account, you may simply discontinue using the Service or contact us to request account deletion.
            </p>
          </section>

          <!-- Governing Law -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">13. Governing Law</h2>
            <p class="text-gray-700 leading-relaxed">
              These Terms shall be interpreted and governed by the laws of the United States, without regard to its conflict of law provisions. Our failure to enforce any right or provision of these Terms will not be considered a waiver of those rights.
            </p>
          </section>

          <!-- Changes to Terms -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">14. Changes to Terms</h2>
            <p class="text-gray-700 leading-relaxed">
              We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.
            </p>
          </section>

          <!-- Contact Information -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">15. Contact Information</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              If you have any questions about these Terms of Service, please contact us:
            </p>
            <div class="bg-gray-50 rounded-lg p-4">
              <p class="text-gray-700">
                <strong>Email:</strong> <a :href="emailLink" class="text-teal-800 hover:text-teal-600">{{ BRAND_EMAIL }}</a><br>
                <strong>Website:</strong> <a :href="BRAND_WEBSITE" class="text-teal-800 hover:text-teal-600">{{ BRAND_WEBSITE }}</a>
              </p>
            </div>
          </section>
        </div>
      </div>

      <!-- Navigation -->
      <div class="mt-8 text-center">
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <router-link
            to="/legal/privacy-policy"
            class="bg-teal-800 text-white px-6 py-3 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200"
          >
            Privacy Policy
          </router-link>
          <router-link
            to="/"
            class="bg-gray-100 text-gray-700 px-6 py-3 rounded-lg font-semibold hover:bg-gray-200 transition-colors duration-200"
          >
            Back to Home
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { BRAND_NAME, BRAND_EMAIL, BRAND_WEBSITE } from '../../lib/config'

const lastUpdated = 'January 15, 2025'

const emailLink = computed(() => `mailto:${BRAND_EMAIL}`)
</script>