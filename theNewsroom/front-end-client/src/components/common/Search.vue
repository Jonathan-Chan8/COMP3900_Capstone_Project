<template>
<v-dialog d-flex elevation="0" v-model="show" width="1000px" height="500px">
    <v-card class="flex-wrap text-justify justify-space-between">
        <v-card-title class="headline"> Search: {{this.keyword}}</v-card-title>
        <v-divider />

    </v-card>

</v-dialog>
</template>

<script>
import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

export default {
    props: {
        value: Boolean
    },

    components: {

    },

    computed: {
        ...mapState(['popups', 'selected', 'current_topic', 'keyword']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getPopups']),

        show: {
            get() {
                return this.value
            },
            set(value) {
                this.$emit('input', value)
            }
        }
    },
    methods: {
        ...mapMutations([
            'addSelected',
            'removeSelected',
            'openTopic',
            'nextTopic',
            'previousTopic',
            'closeTopic',
            'openArticle',
        ]),
        close() {
            this.show = false
        },
    },

    data: () => ({

    }),

    apollo: {

    },

}
</script>

<style scoped>
.v-list-item {
    justify-content: center !important;
    flex-direction: row !important;
    text-align: center !important;
    align-items: center !important;
}

.item {
    background: rgb(243, 245, 245);

}

.item:hover {
    background: rgb(239, 240, 240);

}
</style>
