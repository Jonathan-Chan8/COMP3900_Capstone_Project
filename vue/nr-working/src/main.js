
import Vue from 'vue'
import App from './App.vue'
import router from './router/'
import vuetify from './plugins/vuetify';
// import 'bulma/css/bulma.css';
import './scss/main.scss';
import VueTouch from 'vue-touch';
 
Vue.use(VueTouch)


// Import the Auth0 configuration
import { domain, clientId, audience } from "../auth_config.json";

// Import the plugin here
import { Auth0Plugin } from "./auth";


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
    );
  }
});

Vue.config.productionTip = false

new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')
