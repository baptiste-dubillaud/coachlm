<script setup lang="ts">

const props = defineProps<{
    type?: 'button' | 'reset'
    level?: 'primary' | 'secondary'
    click?: () => void
}>()

</script>

<template>
    <button 
    class="basic-button" 
    :type="props.type || 'button'" 
    :data-level="props.level || 'primary'" 
    @click="props.click">
        <slot></slot>
    </button>
</template>

<style scoped lang="scss">
.basic-button {
    background-color: var(--vt-accent-primary);
    border: 1px solid var(--vt-accent-primary-dark);
    border-radius: 5px;
    cursor: pointer;
    color: var(--vt-text-primary);

    display: flex;
    align-items: center;
    justify-content: center;

    padding: 10px 20px;
    font-size: 1rem;
    font-weight: 500;
    font-family: var(--vt-font-family);
}

.basic-button[data-level='secondary'] {
    background-color: var(--vt-bg-secondary);
    border: 1px solid var(--vt-border-secondary);
    color: var(--vt-text-secondary);
}

.basic-button:hover {
    background-color: var(--vt-accent-primary-hover);
}

.basic-button[data-level='secondary']:hover {
    background-color: var(--vt-bg-secondary-hover);
}

.basic-button:disabled {
    background-color: var(--vt-bg-disabled);
    border: 1px solid var(--vt-border-disabled);
    color: var(--vt-text-disabled);
    cursor: not-allowed;
}

.basic-button[type='reset'] {
    background-color: var(--vt-red);
    border: 1px solid var(--vt-red-border);
    color: var(--vt-text-secondary);
}

.basic-button[type='reset']:hover {
    background-color: var(--vt-red-hover);
}


</style>