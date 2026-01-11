<script setup lang="ts">
import ThemeSelectorButton from '@/components/buttons/themeSelector/ThemeSelectorButton.vue';

</script>

<template>
    <header class="app-header">
        
        <div class="header-left">
            <div class="logo-container">
                <a href="/" class="logo-link">
                    
                    <h1>CoachLM</h1>
                </a>
            </div>
        </div>

        <div class="header-right">
            <ThemeSelectorButton />
        </div>
    </header>
</template>

<style scoped lang="scss">
.app-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 1rem 2rem;
    background-color: var(--vt-accent-primary);
    border-bottom: 1px solid var(--vt-accent-primary-dark);
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.header-left {
    display: flex;
    align-items: center;
    gap: 2rem;
}

.header-right {
    display: flex;
    align-items: center;
    gap: 1rem;
}

.logo-container {
    .logo-link {
        display: block;
        text-decoration: none;

        &:hover {
            transform: scale(1.05);
            transition: transform 0.2s ease;
        }
    }
}
</style>