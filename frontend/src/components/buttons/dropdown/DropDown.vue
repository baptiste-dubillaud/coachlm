<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue'
import Button from '@/components/buttons/basic/Button.vue'
import { type DropDownItem } from '@/components/buttons/dropdown/types/DropDownItem'

const props = defineProps<{
    items: DropDownItem[]
    label?: string
    level?: 'primary' | 'secondary'
    placeholder?: string
}>()

const emit = defineEmits<{
    select: [item: DropDownItem]
}>()

const isOpen = ref(false)
const dropdownRef = ref<HTMLElement | null>(null)

const toggleDropdown = () => {
    isOpen.value = !isOpen.value
}

const selectItem = (item: DropDownItem) => {
    if (item.disabled) return
    emit('select', item)
    isOpen.value = false
}

const handleClickOutside = (event: MouseEvent) => {
    if (dropdownRef.value && !dropdownRef.value.contains(event.target as Node)) {
        isOpen.value = false
    }
}

onMounted(() => {
    document.addEventListener('click', handleClickOutside)
})

onUnmounted(() => {
    document.removeEventListener('click', handleClickOutside)
})
</script>

<template>
    <div class="dropdown" ref="dropdownRef">
        <Button 
            :level="props.level || 'primary'" 
            :click="toggleDropdown"
            class="dropdown-trigger">
            <span>{{ props.label || props.placeholder || 'Select' }}</span>
            <font-awesome-icon 
                icon="chevron-down" 
                class="dropdown-arrow" 
                :class="{ open: isOpen }" />
        </Button>
        
        <transition name="dropdown-fade">
            <div v-if="isOpen" class="dropdown-menu">
                <button
                    v-for="item in props.items"
                    :key="item.value"
                    class="dropdown-item"
                    :class="{ disabled: item.disabled }"
                    :disabled="item.disabled"
                    @click="selectItem(item)"
                    type="button">
                    <font-awesome-icon 
                        v-if="item.icon" 
                        :icon="item.icon" 
                        class="item-icon" />
                    <span>{{ item.label }}</span>
                </button>
            </div>
        </transition>
    </div>
</template>

<style scoped lang="scss">
.dropdown {
    position: relative;
    display: inline-block;
}

.dropdown-trigger {
    gap: 8px;
    min-width: 150px;
    background-color: var(--vt-accent-primary);
}

.dropdown-trigger:hover {
    background-color: var(--vt-accent-primary-hover);
}

.dropdown-arrow {
    font-size: 0.75rem;
    transition: transform 0.3s ease;
    
    &.open {
        transform: rotate(180deg);
    }
}

.dropdown-menu {
    position: absolute;
    top: calc(100% + 4px);
    left: 0;
    min-width: 100%;
    background-color: var(--vt-bg-primary);
    border: 1px solid var(--vt-border-secondary);
    border-radius: 5px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    z-index: 1000;
    overflow: hidden;
}

.dropdown-item {
    width: 100%;
    display: flex;
    align-items: center;
    gap: 8px;
    padding: 10px 16px;
    background: transparent;
    border: none;
    color: var(--vt-text-primary);
    font-size: 1rem;
    font-family: var(--vt-font-family);
    cursor: pointer;
    text-align: left;
    transition: background-color 0.2s ease;
    
    &:hover:not(.disabled) {
        background-color: var(--vt-bg-secondary-hover);
    }
    
    &.disabled {
        color: var(--vt-text-disabled);
        cursor: not-allowed;
        opacity: 0.5;
    }
}

.item-icon {
    font-size: 0.875rem;
    width: 16px;
}

.dropdown-fade-enter-active,
.dropdown-fade-leave-active {
    transition: opacity 0.2s ease, transform 0.2s ease;
}

.dropdown-fade-enter-from {
    opacity: 0;
    transform: translateY(-8px);
}

.dropdown-fade-leave-to {
    opacity: 0;
    transform: translateY(-8px);
}
</style>
