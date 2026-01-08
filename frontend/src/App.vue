<script setup>
import AppHeader from "@/core/header/AppHeader.vue";
</script>

<template>
    <div class="app-container">
        <!-- Header of the application -->
        <AppHeader />

        <!-- Main content of the application -->
        <main class="main-content">
            <router-view />
        </main>

        <!-- Footer of the application -->
        <!-- <Footer /> -->
    </div>
</template>

<style scoped>
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
