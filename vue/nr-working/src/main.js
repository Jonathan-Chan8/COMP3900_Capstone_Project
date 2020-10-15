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
import Profile from './views/Profile.vue';
import Credits from './views/Credits.vue';


import './scss/main.scss';
import { domain, clientId } from "../auth_config.json";
import { Auth0Plugin } from "./auth";
import { authGuard } from "./auth/authGuard";
Vue.config.productionTip = false

Vue.use(Router)
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





let router = new Router({
  mode: 'history',
  base: process.env.BASE_URL,

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

      },
      {
          path: '/register',
          name: 'register',
          component: Register,

      },
      {
          path: '/topics',
          name: 'topics',
          component: Topics,

      },
      {
          path: '/trends',
          name: 'trends',
          component: Trends,

      },

      {
        path: '/credits',
        name: 'credits',
        component: Credits,

    },
      {
        path: '/saved',
        name: 'saved',
        component: Saved,
        beforeEnter: authGuard


      },
      {
        path: "/profile",
        name: "profile",
        component: Profile,
        beforeEnter: authGuard

      }
  ]
})

new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')
