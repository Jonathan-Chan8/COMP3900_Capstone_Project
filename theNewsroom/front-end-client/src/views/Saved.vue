<template>
<div class="home">
    <h1 class="subheading grey--text text-center">Saved Trends</h1>
    <v-container fluid>
        <v-row>
            <v-card tile flat class="flex-wrap text-justify justify-space-between">
                <v-card-title>Saved Trends</v-card-title>
                <v-list width=100% rounded>
                    <v-card tile flat class="saved flex-wrap text-justify justify-space-between" v-for="config in saved" :key="config" @click="viewTrends(config.topics)">
                        <v-card-title class="headline" v-text="config.title"> </v-card-title>

                        <v-card-actions>
                            <v-row dense>
                                <!-- we would need ot make sure we limit the number of characters shown -->
                                <v-col v-for="topic in config.topics" :key="topic.title">
                                    <v-btn width=100% depressed @click="open(topic.title)">{{ topic.title }}</v-btn>
                                </v-col>
                                <Popup v-model="popup" />
                            </v-row>
                        </v-card-actions>
                        <v-divider />
                        <div />
                    </v-card>
                </v-list>
            </v-card>

        </v-row>
    </v-container>

</div>
</template>

<!-- Need to figure out a way to only show the correct cards for if a user is signed in or not -->

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
        saved: {
            config1: {
                title: "Politics",
                topics: [{
                        title: 'Coronavirus',
                    },
                    {
                        title: 'U.S. Election',
                    },
                    {
                        title: 'Californian Bushfires',
                    },
                    {
                        title: 'New Zealand',
                    },
                    {
                        title: 'Melbourne',
                    },
                ],
            },
            config2: {
                title: "Coronavirus",
                topics: [{
                        title: 'Coronavirus',
                    },
                    {
                        title: 'U.S. Election',
                    },
                    {
                        title: 'Californian Bushfires',
                    },
                    {
                        title: 'New Zealand',
                    },
                    {
                        title: 'Melbourne',
                    },
                ],
            },
            config3: {
                title: "Australia",
                topics: [{
                        title: 'Coronavirus',
                    },
                    {
                        title: 'U.S. Election',
                    },
                    {
                        title: 'Californian Bushfires',
                    },
                    {
                        title: 'New Zealand',
                    },
                    {
                        title: 'Melbourne',
                    },
                    {
                        title: 'Coronavirus',
                    },
                    {
                        title: 'U.S. Election',
                    },
                    {
                        title: 'Californian Bushfires',
                    },
                    {
                        title: 'New Zealand',
                    },
                    {
                        title: 'Melbourne',
                    },
                ],
            }
        }
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
            'setSelected'
        ]),
        open(title) {
            this.popup = true
            this.openTopic(title)
        },
        viewTrends(topics) {

            this.emptySelected()
            var i
            for (i = 0; i < topics.length; i++) {
                this.addSelected(topics[i].title)
            }
            this.$router.push({
                name: 'trends'
            })
        }
    },
    computed: {
        ...mapState(['popup', 'popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected']),
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
