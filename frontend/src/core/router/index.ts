import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    /* Application feature routes */
    {
      path: '/',
      name: 'home',
      component: () => import('@/core/pages/home/Home.vue'),
    }

    /* Application auth routes */,
    /* {
      path: '/auth/login',
      name: 'login',
      component: () => import('@/core/pages/auth/Login.vue'),
    } */
  ],
})

export default router
