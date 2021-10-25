const colors = require('tailwindcss/colors')

module.exports = {
  mode: 'jit',
  purge: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
    colors: {
      ...colors,
      honey: "#FFC30B"
    },
    fontFamily: {
      kalam: ['Kalam'],
      roboto: ['Roboto']
    }
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
