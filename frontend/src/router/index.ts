import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
        path: '/',
        name: 'home',
        component: () => import('@/core/pages/home/Home.vue')
    },
    {
        path: '/training',
        name: 'training',
        component: () => import('@/core/pages/training/Training.vue')
    }
  ]
})

export default router
