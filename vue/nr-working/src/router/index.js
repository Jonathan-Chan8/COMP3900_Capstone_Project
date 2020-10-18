import Home from '../views/Home';
import NotFound from '../views/NotFound';
import Topics from '../views/Topics';
import Trends from '../views/Trends';
import Login from '../views/Login';
import Register from '../views/Register';
import Saved from '../views/Saved';
import Profile from '../views/Profile';
import Credits from '../views/Credits';

import Vue from 'vue'
import Router from 'vue-router'
import { authGuard } from "../auth/authGuard";
import ExternalApiView from "../views/ExternalApi.vue";


Vue.use(Router)

export default new Router({
  mode: 'history',
  base: process.env.BASE_URL,
  routes: [
    {
        path: "/external-api",
        name: "external-api",
        component: ExternalApiView,
        beforeEnter: authGuard
      },
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