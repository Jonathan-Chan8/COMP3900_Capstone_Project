<template>
<div class="home">
    <h1 class="subheading grey--text text-center">Saved Trends</h1>
    <v-container fluid>
        <v-row>
            <v-list two-line width=100% rounded>
                <v-list-item flat class="flex-wrap text-justify justify-space-between" v-for="config in getSaved" :key="config" depressed hover @click.stop="viewTrends(config.topics)">
                    <v-col d-flex>
                        <v-list-item-title class="headline" v-text="config.title" />
                        <v-card-actions>
                            <v-col md=10 sm=10 xs=10>
                                <v-row dense>
                                    <!-- We would need ot make sure we limit the number of characters shown -->
                                    <v-col v-for="topic in config.topics" :key="topic">
                                        <v-btn rounded width=100% depressed @click.stop="open(topic)" v-text='topic' />
                                    </v-col>
                                </v-row>
                            </v-col>
                            <v-col md=2 sm=3 xs=3>
                                <v-btn text rounded width=100% depressed @click.stop="editTrend(config)">
                                    Edit
                                </v-btn>
                                <v-btn text rounded width=100% depressed @click.stop="deleteTrend(config)">
                                    Delete
                                </v-btn>
                            </v-col>
                        </v-card-actions>
                    </v-col>
                </v-list-item>
            </v-list>
        </v-row>
        <Popup v-model="popup" />
    </v-container>
</div>
</template>

<script>
import Popup from "../components/common/Popup";

import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

export default {
    name: "Topics",
    components: {
        Popup
    },

    data: () => ({
        popup: false,
    }),

    methods: {
        ...mapMutations([
            'addSelected',
            'removeSelected',
            'openTopic',
            'nextTopic',
            'previousTopic',
            'closeTopic',
            'emptySelected',
            'setSelected',
            'saveTrend'
        ]),
        open(title) {
            this.popup = true
            this.openTopic(title)
        },
        viewTrends(selection) {
            this.setSelected(selection)
            this.$router.push({
                name: 'trends'
            })
        }
    },
    computed: {
        ...mapState(['popup', 'popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getSaved', 'getRelated']),
    },
}
</script>

<style scoped>
td {
    text-align: center !important;
}

.saved {
    padding-top: 20px;
}
</style>
