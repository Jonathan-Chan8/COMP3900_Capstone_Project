import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import Router from 'vue-router'

import Home from './views/Home';
import NotFound from './views/NotFound';
import Topics from './views/Topics';
import Trends from './views/Trends';
import Login from './views/Login';
import Register from './views/Register';
import Saved from './views/Saved';

// Import the Auth0 configuration
import { domain, clientId } from "../auth_config.json";

// Import the plugin here
import { Auth0Plugin } from "./auth";

Vue.use(Auth0Plugin, {
  domain,
  clientId,
  onRedirectCallback: appState => {
    router.push(
      appState && appState.targetUrl
        ? appState.targetUrl
        : window.location.pathname
    );
  }
});

Vue.config.productionTip = false;

Vue.use(Router)

import './scss/main.scss';

Vue.config.productionTip = false

let router = new Router({
  mode: 'history',
  routes: [
      {   
          path: '*', 
          name: 'notfound',
          component: NotFound 
      },
      {
          path: '/',
          name: 'home',
          component: Home
      },
      {
          path: '/login',
          name: 'login',
          component: Login,
          meta: {
              guest: true
          }
      },
      {
          path: '/register',
          name: 'register',
          component: Register,
          meta: {
              guest: true
          }
      },
      {
          path: '/topics',
          name: 'topics',
          component: Topics,
          meta: {
            guest: true
          }
      },
      {
          path: '/trends',
          name: 'trends',
          component: Trends,
          meta: {
            guest: true
          }
      },
      {
        path: '/saved',
        name: 'saved',
        component: Saved,
        meta: {
          requiresAuth: true,
        }
    },
  ]
})

new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')
