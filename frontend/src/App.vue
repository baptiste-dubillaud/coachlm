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
    display: flex;
    flex: 1;
    width: 100%;
    height: calc(100vh - var(--vt-header-height));
    overflow-y: auto;
    flex-direction: column;
    background-color: var(--vt-bg-primary);
    color: var(--vt-text-primary);
    font-family: var(--vt-font-family);
}
</style>
