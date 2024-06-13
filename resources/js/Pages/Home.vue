<template>
    <div ref="container" class="overflow-y-auto h-screen">
        <ul class="border rounded py-0 mx-auto my-5 max-w-lg divide-y divide-gray-100">
            <li v-for="character in characters" :key="character.id" class="">
                <router-link :to="{ name: 'character', params: { id: character.id } }">
                    <Card :character="character" />
                </router-link>
            </li>
        </ul>
        <div v-if="loading">
            <Loader />
        </div>
    </div>
</template>

<script>

import axios from 'axios';
import Card from '@/Pages/components/Card.vue';
import Loader from '@/Pages/components/Loader.vue';

export default {
    components: {
        Card,
        Loader
    },
    data() {
        return {
            characters: [],
            loading: false,
            currentPage: 1,
        };
    },
    mounted() {
        this.loadCharacters();
        this.setupScrollListener();
    },
    methods: {
        async loadCharacters() {

            if (this.loading) return;
            this.loading = true;
            
            try {
                const response = await axios.get(`/api/character/page/${this.currentPage}`);
                const newCharacters = response.data.results;
                console.log(newCharacters);

                this.characters = [...this.characters, ...newCharacters];
                this.currentPage += 1;

            } catch (error) {
                console.error('Error:', error);
            } finally {
                this.loading = false;
            }
        },
        setupScrollListener() {
            
            const container = this.$refs.container;

            container.addEventListener('scroll', () => {
                if (container.scrollTop + container.clientHeight >= container.scrollHeight - 10) {
                    this.loadCharacters();
                }
            });
        },
    },
};
</script>