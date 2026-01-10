import '@/assets/main.scss'

import { createApp } from 'vue'
import App from './App.vue'
import router from './core/router'

/* import font awesome icon component */
import { library } from '@fortawesome/fontawesome-svg-core'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

/* import specific icons */
import { faUserSecret, faMoon, faSun } from '@fortawesome/free-solid-svg-icons'
library.add(faUserSecret, faMoon, faSun)

const app = createApp(App)

app.component('font-awesome-icon', FontAwesomeIcon)
app.use(router)

app.mount('#app')
