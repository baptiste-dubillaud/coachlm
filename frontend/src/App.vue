<template>
    <div class="container">
        <h1>{{ message }}</h1>
        <p class="subtitle">Welcome to CoachLM - Your AI-powered coaching platform</p>
        <div class="info">
            <p>Built with Vue.js {{ vueVersion }}</p>
        </div>
    </div>
</template>

<script setup>
import { ref } from "vue";
import { version } from "vue";

const message = ref("Hello World!");
const vueVersion = version;
</script>

<style scoped>
.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 100vh;
    text-align: center;
    padding: 2rem;
}

h1 {
    font-size: 3.5rem;
    font-weight: bold;
    margin-bottom: 1rem;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.subtitle {
    font-size: 1.25rem;
    color: #666;
    margin-bottom: 2rem;
}

.info {
    padding: 1rem 2rem;
    background: #f5f5f5;
    border-radius: 8px;
    font-size: 0.9rem;
    color: #555;
}
</style>
