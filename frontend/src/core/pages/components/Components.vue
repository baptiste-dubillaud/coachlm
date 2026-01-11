<script setup lang="ts">

import Button from '@/components/buttons/basic/Button.vue';

</script>

<template>
    <h1>Components Demo</h1>

    <br>
    <p>Here is a list of all self-implemented components and their variants developed in this project</p>

    <br>
    <h2>Buttons</h2>

    <div>
        <Button level="primary">Primary Button</Button>
        <Button level="secondary">Secondary Button</Button>
        <Button type="reset">Cancel Button</Button>
    </div>
</template>

<style scoped lang="scss">
div {
    display: flex;
    gap: 10px;
    margin-top: 20px;
}
</style>