<script setup>
import { ref, onMounted } from 'vue'
import Button from '@/components/buttons/basic/Button.vue'

const isDark = ref(false)

const applyTheme = () => {
    if (isDark.value) {
        document.documentElement.classList.add('dark-theme')
        localStorage.setItem('theme', 'dark')
    } else {
        document.documentElement.classList.remove('dark-theme')
        localStorage.setItem('theme', 'light')
    }
}

const toggleTheme = () => {
    isDark.value = !isDark.value
    applyTheme()
}

onMounted(() => {
    const savedTheme = localStorage.getItem('theme')
    if (savedTheme) {
        isDark.value = savedTheme === 'dark'
    } else {
        isDark.value = window.matchMedia('(prefers-color-scheme: dark)').matches
    }
    applyTheme()
})
</script>

<template>
    <div class="theme-switcher">
        <Button level="secondary" @click="toggleTheme">
            <font-awesome-icon :icon="isDark ? 'fas fa-sun' : 'fas fa-moon'" class="icon"></font-awesome-icon>
        </Button>
    </div>
</template>

<style lang="scss" scoped>
@use '@/assets/base.scss';

.icon {
    font-size: 1.3rem;
}

:deep(.basic-button[data-level='secondary']) {
    background-color: var(--vt-accent-primary);
    border: 1px solid var(--vt-accent-primary-dark);
}

:deep(.basic-button[data-level='secondary']):hover {
    background-color: var(--vt-accent-primary-hover);
}

</style>