<template>
<v-dialog d-flex elevation="0" v-model="show" width="1000px" height="500px">
    <v-card class="flex-wrap text-justify justify-space-between">
        <v-card-title class="headline"> Search: {{this.keyword}}</v-card-title>
        <v-divider />
        <v-card-actions>
            <v-row dense>
                <!-- We would need ot make sure we limit the number of characters shown -->
                <v-col v-for="topic in results" :key="topic.id" md=6>
                    <v-btn rounded width=100% depressed @click.stop="open(topic)" v-text='topic.name' />
                </v-col>
            </v-row>
        </v-card-actions>

    </v-card>
    <Popup v-model="popup" />

</v-dialog>
</template>

<script>
import Popup from "./Popup"

import SEARCH_FOR_TOPIC from '../../graphql/SearchForTopic.gql'

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
        Popup
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
        open(topic) {
            this.popup = true
            this.openTopic(topic)
        },
        close() {
            this.show = false
        },
    },

    data: () => ({
        popup: false,
        results: []
    }),

    apollo: {

        results: {
            query: SEARCH_FOR_TOPIC,
            variables() {
                return {
                    keyword: this.keyword
                }
            },
            update(data) {
                return data.allTopics.nodes;
            }
        }

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
