module.exports = {
  publicPath: process.env.NODE_ENV === 'production'
    ? '/vuetify'
    : '/',
  "transpileDependencies": [
    "vuetify"
  ],
  devServer: {
    proxy: {
      "/api": {
        target: "http://localhost:3001"
      }
    }
  }
}