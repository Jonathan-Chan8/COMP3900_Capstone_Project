<template>
<div class="home">
    <h1 class="subheading grey--text text-center">Saved Trends</h1>
    <v-container fluid>
        <v-row>
            <v-list two-line width=100% rounded>
                <v-list-item flat class="flex-wrap text-justify justify-space-between" v-for="config in saved" :key="config" depressed hover @click.stop="viewTrends(config.topics)">
                    <v-col>
                        <v-list-item-title class="headline" v-text="config.title"> </v-list-item-title>
                        <v-card-actions>
                            <v-row dense>
                                <!-- we would need ot make sure we limit the number of characters shown -->
                                <v-col v-for="topic in config.topics" :key="topic.title">
                                    <v-btn rounded width=100% depressed @click.stop="open(topic.title)">{{ topic.title }}</v-btn>
                                </v-col>
                                <Popup v-model="popup" />
                            </v-row>
                        </v-card-actions>
                    </v-col>
                </v-list-item>
            </v-list>
        </v-row>
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
        saved: [{
                title: "U.S. Politics",
                topics: [{
                        title: 'Joe Biden',
                    },
                    {
                        title: 'U.S. Election',
                    },
                    {
                        title: 'Donald Trume',
                    },
                    {
                        title: 'Supreme Court',
                    }
                ],
            },
            {
                title: "Coronavirus",
                topics: [{
                        title: 'Coronavirus',
                    },
                    {
                        title: 'Vaccine',
                    },
                    {
                        title: 'Australia',
                    },
                    {
                        title: 'New Zealand',
                    },
                    {
                        title: 'Melbourne',
                    },
                ],
            },
            {
                title: "World Events",
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
                        title: 'Brexit',
                    },
                ],
            }
        ],

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
