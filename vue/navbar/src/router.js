import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Topics from './views/Topics.vue'
import Trends from './views/Trends.vue'
import Login from './views/Login.vue'
import Register from './views/Register.vue'


Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/topics',
      name: 'topics',
      component: Topics
    },
    {
      path: '/trends',
      name: 'trends',
      component: Trends
    }
    ,
    {
      path: '/login',
      name: 'login',
      component: Login
    },
    {
      path: '/register',
      name: 'register',
      component: Register
    }

  ]
})
