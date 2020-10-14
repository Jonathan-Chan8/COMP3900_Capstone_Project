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
