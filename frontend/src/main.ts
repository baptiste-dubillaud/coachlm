import './assets/main.scss'

import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faSun, faMoon } from '@fortawesome/free-solid-svg-icons'

// Add icons to the library
library.add(faSun, faMoon)

import { createApp } from "vue";
import App from "./App.vue";
import router from "./router";
import "./style.css";


const app = createApp(App)
app.component('font-awesome-icon', FontAwesomeIcon)
app.use(router)

// Finally, mount the app to the DOM
app.mount('#app')
