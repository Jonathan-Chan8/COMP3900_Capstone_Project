
import Vue from 'vue'
import App from './App.vue'
import router from './router/'
import store from './store/'

import vuetify from './plugins/vuetify'
import './scss/main.scss'

import VueApexCharts from 'vue-apexcharts'
Vue.use(VueApexCharts)

Vue.component('apexchart', VueApexCharts)

import MultiFiltersPlugin from './plugins/MultiFilters'
Vue.use(MultiFiltersPlugin)


Vue.config.productionTip = false

// Import the Auth0 configuration
import { domain, clientId, audience } from "../auth_config.json"
import { Auth0Plugin } from "./auth/"
import { createProvider } from './plugins/vue-apollo'

// Install the authentication plugin here
Vue.use(Auth0Plugin, {
  domain,
  clientId,
  audience,
  onRedirectCallback: appState => {
    router.push(
      appState && appState.targetUrl
        ? appState.targetUrl
        : window.location.pathname
    )
  }
})



new Vue({
  el: '#app',
  store,
  router,
  vuetify,
  apolloProvider: createProvider(),
  render: h => h(App)
})
