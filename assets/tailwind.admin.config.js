module.exports = {
  mode: 'jit',
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      fontFamily: {
        kalam: ['Kalam'],
        roboto: ['Roboto']
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('daisyui')
  ],
}
