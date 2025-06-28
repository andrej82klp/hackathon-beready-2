import { loadStripe } from '@stripe/stripe-js'

// Initialize Stripe with your publishable key
const stripePromise = loadStripe(import.meta.env.VITE_STRIPE_PUBLISHABLE_KEY || 'pk_test_your_key_here')

export interface DonationData {
  amount: number
  donorName: string
  donorEmail: string
  anonymous: boolean
  newsletter: boolean
}

export const createDonationCheckout = async (donationData: DonationData) => {
  try {
    const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
    const response = await fetch(`${supabaseUrl}/functions/v1/create-donation-checkout`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${import.meta.env.VITE_SUPABASE_ANON_KEY}`,
      },
      body: JSON.stringify(donationData),
    })

    if (!response.ok) {
      const errorData = await response.json()
      throw new Error(errorData.error || 'Failed to create checkout session')
    }

    const { sessionId } = await response.json()
    
    const stripe = await stripePromise
    if (!stripe) {
      throw new Error('Stripe failed to load')
    }

    // Redirect to Stripe Checkout
    const { error } = await stripe.redirectToCheckout({
      sessionId,
    })

    if (error) {
      throw error
    }
  } catch (error) {
    console.error('Error creating donation checkout:', error)
    throw error
  }
}

export { stripePromise }