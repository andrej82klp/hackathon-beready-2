// Brand configuration
export const BRAND_NAME = import.meta.env.VITE_BRAND_NAME || 'BeReady'
export const BRAND_DOMAIN = import.meta.env.VITE_BRAND_DOMAIN || 'beready.org'

// Derived values
export const BRAND_EMAIL = `contact@${BRAND_DOMAIN}`
export const BRAND_TWITTER = `@${BRAND_NAME}Org`
export const BRAND_WEBSITE = `https://${BRAND_DOMAIN}`