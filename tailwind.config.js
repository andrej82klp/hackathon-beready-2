/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{vue,js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        'teal': {
          800: '#0D5A67',
          700: '#0F6B7A',
          600: '#128A9B'
        },
        'yellow': {
          400: '#FBBF24'
        },
        'gray': {
          50: '#F8FAFC'
        }
      },
      fontFamily: {
        'heading': ['Poppins', 'sans-serif'],
        'body': ['Open Sans', 'sans-serif']
      }
    },
  },
  plugins: [],
}