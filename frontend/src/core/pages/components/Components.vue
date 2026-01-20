<script setup lang="ts">
import { ref } from 'vue';

import Button from '@/components/buttons/basic/Button.vue';
import ToggleButton from '@/components/buttons/toggle/ToggleButton.vue';
import DropDown from '@/components/buttons/dropdown/DropDown.vue';

const isEnabled = ref(true);

</script>

<template >
    <div class="components-page">
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
    
        <h2>Switch toggle Button</h2>
    
        <div>
            <ToggleButton v-model="isEnabled" icon-on="fas fa-moon" icon-off="fas fa-sun"/>
            <ToggleButton v-model="isEnabled"></ToggleButton>
        </div>

        <h2>Dropdown Button</h2>
        <div>
            <DropDown 
                :items="[
                    { label: 'Option 1', value: 1 },
                    { label: 'Option 2', value: 2, disabled: true },
                    { label: 'Option 3', value: 3 }
                ]" 
                label="Select an option" 
                placeholder="Choose..."/>

            <DropDown 
                :items="[
                    { label: 'Option 1', value: 1 },
                    { label: 'Option 2', value: 2, disabled: true },
                    { label: 'Option 3', value: 3 }
                ]" 
                label="Select an option" 
                level="secondary" 
                placeholder="Choose..."/>
        </div>  
    </div>
</template>

<style scoped lang="scss">
div {
    display: flex;
    gap: 10px;
    margin: 10px 0;
}

.components-page {
    padding: 20px;
    display: flex;
    flex-direction: column;
}
</style>