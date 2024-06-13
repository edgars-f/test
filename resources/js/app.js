import "./bootstrap";
import router from "./router";
import { createApp } from "vue";
import 'flowbite';

import App from "./App.vue";

createApp(App).use(router).mount("#app");