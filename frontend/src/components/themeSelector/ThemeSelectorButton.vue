<script setup>
import { ref, onMounted } from 'vue'

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
        <!-- Theme Toggle Button -->
        <button @click="toggleTheme" class="theme-toggle-button">
            <font-awesome-icon :icon="isDark ? 'fas fa-sun' : 'fas fa-moon'" class="icon"></font-awesome-icon>
        </button>
    </div>
</template>

<style lang="scss" scoped>
@use '@/assets/base.scss';

.theme-toggle-button {
    background-color: var(--vt-bg-secondary);
    border: 1px solid var(--vt-border-primary);
    border-radius: 5px;
    cursor: pointer;
    color: var(--vt-text-primary);

    display: flex;
    align-items: center;
    justify-content: center;

    width: 50px;
    
    padding: 10px 0px;

    .icon {
        font-size: 1.3rem;
    }
}

</style>