import { createRouter, createWebHistory } from "vue-router";

const routes = [
    {
        path: "/",
        component: () => import("./Pages/Home.vue"),
    },
    {
        path: "/character/:id",
        name: "character",
        component: () => import("./Pages/Character.vue"),
    }
];

export default createRouter({
    history: createWebHistory(),
    routes,
});