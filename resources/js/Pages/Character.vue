<template>
    <div ref="container" class="container border rounded my-5 max-w-lg mx-auto">
        <div v-if="character">
            <Card :character="character" />
        </div>
        <div v-else>
            <Loader />
        </div>
    </div>
</template>

<script>

import axios from 'axios';
import Card from '@/Pages/components/Card.vue';
import Loader from '@/Pages/components/Loader.vue';

export default {
    data() {
        return {
            character: null,
        };
    },
    components: {
        Card,
        Loader
    },
    mounted() {
        const characterId = this.$route.params.id;
        axios.get(`/api/character/${characterId}`)
            .then(response => {
                this.character = response.data;
                console.log(response.data);
            })
            .catch(error => {
                console.error("There was an error fetching the character data:", error);
            });
    },
};
</script>