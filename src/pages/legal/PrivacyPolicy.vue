<template>
  <div class="py-12 bg-gray-50 min-h-screen">
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="text-center mb-12">
        <h1 class="text-4xl md:text-5xl font-heading font-bold text-teal-800 mb-4">
          Privacy Policy
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
              {{ BRAND_NAME }} ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our website {{ BRAND_WEBSITE }} and use our services.
            </p>
            <p class="text-gray-700 leading-relaxed">
              Please read this Privacy Policy carefully. If you do not agree with the terms of this Privacy Policy, please do not access or use our Service.
            </p>
          </section>

          <!-- Information We Collect -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">2. Information We Collect</h2>
            
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Personal Information</h3>
            <p class="text-gray-700 leading-relaxed mb-4">
              We may collect personal information that you voluntarily provide to us when you:
            </p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Create an account on our platform</li>
              <li>Complete learning modules and assessments</li>
              <li>Submit stories or feedback</li>
              <li>Make donations through our platform</li>
              <li>Contact us for support</li>
              <li>Subscribe to our newsletter</li>
            </ul>
            
            <p class="text-gray-700 leading-relaxed mb-4">This information may include:</p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-6">
              <li>Email address</li>
              <li>Name (when provided for stories or donations)</li>
              <li>Location (when voluntarily shared)</li>
              <li>Learning progress and achievement data</li>
              <li>User-generated content (stories, feedback)</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Automatically Collected Information</h3>
            <p class="text-gray-700 leading-relaxed mb-4">
              When you visit our Service, we may automatically collect certain information about your device and usage patterns:
            </p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>IP address and general location information</li>
              <li>Browser type and version</li>
              <li>Operating system</li>
              <li>Pages visited and time spent on pages</li>
              <li>Referring website addresses</li>
              <li>Device identifiers</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Cookies and Tracking Technologies</h3>
            <p class="text-gray-700 leading-relaxed">
              We use cookies and similar tracking technologies to enhance your experience, analyze usage patterns, and improve our Service. You can control cookie preferences through your browser settings.
            </p>
          </section>

          <!-- How We Use Information -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">3. How We Use Your Information</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              We use the information we collect for the following purposes:
            </p>
            
            <h3 class="text-lg font-semibold text-gray-800 mb-3">Service Provision</h3>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Create and manage your user account</li>
              <li>Track your learning progress and achievements</li>
              <li>Provide personalized learning experiences</li>
              <li>Enable community features like story sharing</li>
              <li>Process donations and provide receipts</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Communication</h3>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Send important updates about our Service</li>
              <li>Respond to your inquiries and support requests</li>
              <li>Send newsletters (with your consent)</li>
              <li>Notify you of new features or content</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Improvement and Analytics</h3>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Analyze usage patterns to improve our Service</li>
              <li>Develop new features and content</li>
              <li>Monitor and prevent fraud or abuse</li>
              <li>Ensure technical functionality and security</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Legal Compliance</h3>
            <ul class="list-disc list-inside text-gray-700 space-y-2">
              <li>Comply with applicable laws and regulations</li>
              <li>Respond to legal requests and prevent harm</li>
              <li>Enforce our Terms of Service</li>
            </ul>
          </section>

          <!-- Information Sharing -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">4. How We Share Your Information</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              We do not sell, trade, or rent your personal information to third parties. We may share your information in the following limited circumstances:
            </p>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Service Providers</h3>
            <p class="text-gray-700 leading-relaxed mb-4">
              We may share information with trusted third-party service providers who assist us in operating our Service:
            </p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li><strong>Supabase:</strong> Database and authentication services</li>
              <li><strong>Stripe:</strong> Payment processing for donations</li>
              <li><strong>Email service providers:</strong> For sending communications</li>
              <li><strong>Analytics providers:</strong> For usage analysis and improvement</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Public Information</h3>
            <p class="text-gray-700 leading-relaxed mb-4">
              Some information may be publicly visible:
            </p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Approved user stories (with your consent)</li>
              <li>Achievement badges (when you choose to share them)</li>
              <li>Public comments or feedback (when submitted to public areas)</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Legal Requirements</h3>
            <p class="text-gray-700 leading-relaxed">
              We may disclose your information if required by law, court order, or to protect the rights, property, or safety of {{ BRAND_NAME }}, our users, or others.
            </p>
          </section>

          <!-- Data Security -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">5. Data Security</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              We implement appropriate technical and organizational security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction:
            </p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Encryption of data in transit and at rest</li>
              <li>Regular security assessments and updates</li>
              <li>Access controls and authentication measures</li>
              <li>Secure hosting infrastructure</li>
              <li>Regular backups and disaster recovery procedures</li>
            </ul>
            <div class="bg-yellow-50 border-l-4 border-yellow-400 p-4">
              <p class="text-yellow-800">
                <strong>Note:</strong> While we strive to protect your personal information, no method of transmission over the internet or electronic storage is 100% secure. We cannot guarantee absolute security.
              </p>
            </div>
          </section>

          <!-- Data Retention -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">6. Data Retention</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              We retain your personal information only for as long as necessary to fulfill the purposes outlined in this Privacy Policy:
            </p>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li><strong>Account data:</strong> Until you delete your account or request deletion</li>
              <li><strong>Learning progress:</strong> Retained to provide continuous service</li>
              <li><strong>Stories and feedback:</strong> Retained indefinitely if approved for publication</li>
              <li><strong>Analytics data:</strong> Aggregated and anonymized after 24 months</li>
              <li><strong>Legal compliance:</strong> As required by applicable laws</li>
            </ul>
            <p class="text-gray-700 leading-relaxed">
              When we no longer need your personal information, we will securely delete or anonymize it.
            </p>
          </section>

          <!-- Your Rights -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">7. Your Privacy Rights</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              Depending on your location, you may have the following rights regarding your personal information:
            </p>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Access and Portability</h3>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Request access to your personal information</li>
              <li>Receive a copy of your data in a portable format</li>
              <li>View your learning progress and achievements</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Correction and Updates</h3>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Update your account information</li>
              <li>Correct inaccurate personal information</li>
              <li>Modify your communication preferences</li>
            </ul>

            <h3 class="text-lg font-semibold text-gray-800 mb-3">Deletion and Restriction</h3>
            <ul class="list-disc list-inside text-gray-700 space-y-2 mb-4">
              <li>Request deletion of your account and personal information</li>
              <li>Restrict processing of your information</li>
              <li>Withdraw consent for optional data processing</li>
            </ul>

            <p class="text-gray-700 leading-relaxed">
              To exercise these rights, please contact us at <a :href="emailLink" class="text-teal-800 hover:text-teal-600">{{ BRAND_EMAIL }}</a>. We will respond to your request within 30 days.
            </p>
          </section>

          <!-- Children's Privacy -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">8. Children's Privacy</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              Our Service is not intended for children under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and believe your child has provided us with personal information, please contact us immediately.
            </p>
            <p class="text-gray-700 leading-relaxed">
              If we discover that we have collected personal information from a child under 13 without parental consent, we will take steps to remove that information from our servers.
            </p>
          </section>

          <!-- International Users -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">9. International Data Transfers</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              Your information may be transferred to and processed in countries other than your own. These countries may have different data protection laws than your jurisdiction.
            </p>
            <p class="text-gray-700 leading-relaxed">
              When we transfer your personal information internationally, we ensure appropriate safeguards are in place to protect your information in accordance with this Privacy Policy.
            </p>
          </section>

          <!-- Third-Party Links -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">10. Third-Party Links</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              Our Service may contain links to third-party websites, services, or applications. We are not responsible for the privacy practices or content of these third parties.
            </p>
            <p class="text-gray-700 leading-relaxed">
              We encourage you to review the privacy policies of any third-party services before providing them with your personal information.
            </p>
          </section>

          <!-- Changes to Privacy Policy -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">11. Changes to This Privacy Policy</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              We may update this Privacy Policy from time to time to reflect changes in our practices or for other operational, legal, or regulatory reasons.
            </p>
            <p class="text-gray-700 leading-relaxed">
              We will notify you of any material changes by posting the new Privacy Policy on this page and updating the "Last updated" date. For significant changes, we may also send you an email notification.
            </p>
          </section>

          <!-- Contact Information -->
          <section class="mb-8">
            <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">12. Contact Us</h2>
            <p class="text-gray-700 leading-relaxed mb-4">
              If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us:
            </p>
            <div class="bg-gray-50 rounded-lg p-4">
              <p class="text-gray-700">
                <strong>Email:</strong> <a :href="emailLink" class="text-teal-800 hover:text-teal-600">{{ BRAND_EMAIL }}</a><br>
                <strong>Website:</strong> <a :href="BRAND_WEBSITE" class="text-teal-800 hover:text-teal-600">{{ BRAND_WEBSITE }}</a><br>
                <strong>Subject Line:</strong> Privacy Policy Inquiry
              </p>
            </div>
          </section>

          <!-- Consent -->
          <section class="mb-8">
            <div class="bg-teal-50 border-2 border-teal-200 rounded-lg p-6">
              <h2 class="text-2xl font-heading font-bold text-teal-800 mb-4">Your Consent</h2>
              <p class="text-teal-800 leading-relaxed">
                By using our Service, you consent to the collection, use, and sharing of your information as described in this Privacy Policy. If you do not agree with our policies and practices, please do not use our Service.
              </p>
            </div>
          </section>
        </div>
      </div>

      <!-- Navigation -->
      <div class="mt-8 text-center">
        <div class="flex flex-col sm:flex-row gap-4 justify-center">
          <router-link
            to="/legal/terms-of-service"
            class="bg-teal-800 text-white px-6 py-3 rounded-lg font-semibold hover:bg-teal-700 transition-colors duration-200"
          >
            Terms of Service
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

const emailLink = computed(() => `mailto:${BRAND_EMAIL}?subject=Privacy Policy Inquiry`)
</script>