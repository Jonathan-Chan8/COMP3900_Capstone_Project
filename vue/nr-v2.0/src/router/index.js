import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';

import VueRouter from 'vue-router'



Vue.use(Vuetify);
import Home from '../views/Home.vue'
import Topics from '../views/Topics.vue'
import Trends from '../views/Trends.vue'
import Login from '../views/Login.vue'
import Register from '../views/Register.vue'
import About from '../views/About.vue'


Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/topics',
    name: 'Topics',
    component: Topics
  },
  {
    path: '/trends',
    name: 'Trends',
    component: Trends
  }
  ,
  {
    path: '/login',
    name: 'Log In',
    component: Login
  },
  {
    path: '/register',
    name: 'Register',
    component: Register
  },
  {
    path: '/about',
    name: 'About',
    component: About
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
