module.exports = {
  mode: 'jit',
  content: [
    './js/**/*.js',
    '../lib/*_web/**/*.*ex'
  ],
  theme: {
    extend: {
      screens: {
        'desktop': '768px',	
      },
      colors: {
        honey: "#FFC30B"
      }
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
