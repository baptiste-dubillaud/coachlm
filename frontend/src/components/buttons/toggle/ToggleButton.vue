<script setup lang="ts">
const props = defineProps<{
    modelValue: boolean
    iconOn?: string
    iconOff?: string
    label?: string
}>()

const emit = defineEmits<{
    'update:modelValue': [value: boolean]
}>()

const toggle = () => {
    emit('update:modelValue', !props.modelValue)
}
</script>

<template>
    <div class="toggle-wrapper">
        <label v-if="label" class="toggle-label">{{ label }}</label>
        <button 
            class="toggle-switch" 
            :class="{ active: modelValue }"
            @click="toggle"
            type="button"
            role="switch"
            :aria-checked="modelValue">
            <span class="toggle-track">
                <span v-if="!iconOn && !iconOff" class="toggle-thumb">
                </span>
                    <font-awesome-icon 
                        :icon="modelValue ? iconOn : iconOff" 
                        class="toggle-icon" />  
            </span>
        </button>
    </div>
</template>

<style scoped lang="scss">
.toggle-wrapper {
    display: flex;
    align-items: center;
    gap: 12px;
}

.toggle-label {
    font-size: 1rem;
    font-weight: 500;
    color: var(--vt-text-primary);
    user-select: none;
}

.toggle-switch {
    position: relative;
    background: transparent;
    border: none;
    padding: 0;
    cursor: pointer;
    outline: none;
    
    .toggle-track {
        display: block;
        width: 57px;
        height: 34px;
        background-color: var(--vt-bg-secondary);
        border: 2px solid var(--vt-border-secondary);
        border-radius: 50px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }
    
    &.active .toggle-track {
        background-color: var(--vt-accent-primary);
    }
    
    &.active .toggle-thumb,
    &.active .toggle-icon {
        transform: translateX(23px);
    }
}

.toggle-thumb,
.toggle-icon {
    position: absolute;
    top: 5px;
    left: 5px;
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    color: var(--vt-text-primary);
}

.toggle-thumb {
    background-color: var(--vt-text-primary);
    border-radius: 50%;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

</style>
