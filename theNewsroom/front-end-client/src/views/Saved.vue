<template>
<div class="home">
    <v-container fluid>

        <h2 class="subheading grey--text text-center" v-if="getSaved.length == 0">Looks like you haven't saved any Trends yet! You can save a selection of topics on the Trends page.</h2>
        <v-row v-else>
            <v-list two-line width=100% rounded>
                <v-list-item>
                    <HelpSaved />
                    <span> Need Help?</span>

                </v-list-item>
                <v-list-item flat class="flex-wrap text-justify justify-space-between" v-for="config in getSaved" :key="config" depressed hover @click.stop="viewTrends(config.topics)">

                    <v-col d-flex>
                        <v-list-item-title class="headline" v-text="config.title" />
                        <v-card-actions>
                            <v-row dense>
                                <!-- We would need ot make sure we limit the number of characters shown -->
                                <v-col v-for="topic in config.topics" :key="topic">
                                    <v-btn rounded width=100% depressed @click.stop="open(topic)" v-text='topic.name' />
                                </v-col>
                            </v-row>
                            <v-row class="edit" dense>
                                <v-spacer />
                                <v-col>
                                    <v-btn outlined text rounded width=100% depressed @click.stop="deleteTrend(config)">
                                        Delete
                                    </v-btn>
                                </v-col>
                            </v-row>
                        </v-card-actions>
                    </v-col>
                </v-list-item>
            </v-list>
        </v-row>
        <Popup v-model="popup" />

    </v-container>
    <!--
    <v-text> Current Topic: {{ current_topic}} </v-text>
    <v-spacer />
    <v-text> Popup Stack: {{ getPopups}} </v-text>
    <v-spacer />
    <v-text> Selected Topics: {{ getSelected}} </v-text>
    <v-spacer />
    <v-text> Saved: {{ getSaved}} </v-text>
    <v-spacer />
    <v-text> Current Saved: {{ current_saved}} </v-text>
    <v-spacer />

    <v-text> Edit: {{editted}} </v-text>
    <v-spacer />

    <v-text> old: {{old}} </v-text>
-->
</div>
</template>

<script>
import Popup from "../components/common/Popup";
import HelpSaved from "../components/common/HelpSaved";

import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

export default {
    name: "Topics",
    components: {
        Popup,
        HelpSaved
    },

    data: () => ({
        trend: {
            title: '',
            topics: []
        },
        dialog: false,
        popup: false,
    }),
    computed: {
        ...mapState(['current_topic', 'saved', 'popups', 'selected', 'related']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getSaved', 'getRelated', 'getPopups']),
    },
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
            'saveTrend',
            'deleteTrend',
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
        },
    },

}
</script>

<style scoped>
td {
    text-align: center !important;
}

.saved {
    padding-top: 20px
}

.edit {
    max-width: 150px;
}
</style>
