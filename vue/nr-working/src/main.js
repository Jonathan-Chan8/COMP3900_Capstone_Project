import Vue from 'vue'
import App from './App.vue'
import vuetify from './plugins/vuetify';
import VueRouter from 'vue-router'

import Home from './views/Home';
import About from './views/About';
import NotFound from './views/NotFound';
import Topics from './views/Topics';
import Trends from './views/Trends';
import Login from './views/Login';
import Register from './views/Register';


Vue.use(VueRouter)

import './scss/main.scss';

Vue.config.productionTip = false

const router = new VueRouter({
  routes: [
    { path: '/', component: Home },
    { path: '/about', component: About },
    { path: '*', component: NotFound },
    { path: '/topics', component: Topics },
    { path: '/trends', component: Trends },
    { path: '/login', component: Login },
    { path: '/register', component: Register }
  ],
  mode: 'hash'
})

new Vue({
  router,
  vuetify,
  render: h => h(App)
}).$mount('#app')
