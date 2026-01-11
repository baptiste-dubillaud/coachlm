<script setup>
import AppHeader from "@/components/header/AppHeader.vue";
</script>

<template>
    <AppHeader />

    <!-- Main content of the application -->
    <main class="app-container main-content">
        <router-view />
    </main>
</template>

<style scoped lang="scss">
.app-container {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    background-color: var(--vt-bg-primary);
    color: var(--vt-text-primary);
    font-family: var(--vt-font-family);
}

.main-content {
    flex: 1;
    width: 100%;
    padding-top: 1rem;
}
</style>
