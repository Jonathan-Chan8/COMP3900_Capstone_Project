<template>
<div>
    <template>

        <div class='body'>
            <img :src="$auth.user.picture">
            <h2>{{ $auth.user.name }}</h2>
            <p>{{ $auth.user.email }}</p>

        </div>
    </template>

    <div>
        <pre>{{ JSON.stringify($auth.user, null, 2) }}</pre>
    </div>

    <p>{{ sub }}</p>

</div>
</template>

<script>
import {
    mapGetters,
    mapState,
    mapMutations,
    mapActions
} from 'vuex';

export default {
    name: "Home",
    components: {

    },

    data() {
        return {
            sub: this.$auth.user,

        }
    },

    methods: {
        ...mapActions(['login']),
        ...mapMutations([
            'addSelected',
            'removeSelected',
            'openTopic',
            'nextTopic',
            'previousTopic',
            'closeTopic'
        ])

    },
    computed: {
        ...mapState(['popup', 'popups', 'selected', 'current_topic', 'user']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected']),
    },
}
</script>

<!-- Defining a v-cards class as card-outter will provide enough spacing for buttons beneath. Not necessary if the entire v-card is a route, but important if we want to include buttons as well -->

<style>
.card-outter {
    position: relative;
    padding-bottom: 50px;
}

.card-actions {
    position: relative;

    bottom: 0;
}
</style>
