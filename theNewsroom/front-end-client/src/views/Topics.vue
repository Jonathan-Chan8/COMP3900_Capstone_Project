<template>
<div class="topics">
    <h1 class="body grey--text text-center"></h1>
    <template>
        <v-spacer />
        <v-layout wrap>
            <v-spacer />
            <v-flex xs10 md3>
                <!-- Really, these filters wont actually filter the datatable, but rather will be used as input to our db query, thus changing the reuslts of the topics list returned by the database -->

                <!-- For now this filters the datatable, really we want it to produce a popup with possible matches on 'enter', and selecting a match will produce the corresponding topic popup. This field ought to be in the same position of the page on both Topics and Trends, to show continuity -->

                <v-card flat tile width='100%'>

                    <v-list flat rounded dense>
                        <!-- Search, calendar and media are subgroups in a the group Filters, allowing us to easily modify this entire list as a single element -->
                        <v-list-group value="true" color="none">

                            <template v-slot:activator>

                                <v-list-item-content>
                                    <v-list-item-title class='font-weight-light list-title'>Filters </v-list-item-title>
                                </v-list-item-content>

                            </template>
                            <!-- Search -->
                            <v-list-item>
                                <v-text-field dense rounded filled v-model="search" append-icon="mdi-magnify" label="Search for a topic" single-line hide-details />
                            </v-list-item>
                            <!-- Calendar (a menu that opens a calendar, the user selects a date range and the date that occurs first is automatically saved as the starting date (to be used in our queries)-->
                            <v-list-item>
                                <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="date" transition="scale-transition" offset-y min-width="290px">
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-text-field dense rounded filled v-model="dateRange" label="Select time period" append-icon="mdi-calendar" single-line hide-details readonly v-bind="attrs" v-on="on" />
                                    </template>
                                    <v-date-picker v-model="dates" :max='todaysDate' range no-title scrollable>
                                        <v-spacer />
                                        <v-btn text color="primary" @click="saveDates">
                                            OK
                                        </v-btn>
                                    </v-date-picker>
                                </v-menu>
                            </v-list-item>
                            <!-- Media selection -->
                            <v-list-item>
                                <v-text-field dense rounded filled v-model="media" append-icon="mdi-book-open-variant" label="Filter by media outlet" single-line hide-details />
                            </v-list-item>

                        </v-list-group>
                        <v-list-item>
                            <v-spacer />
                            <HelpTopics />
                        </v-list-item>

                    </v-list>

                </v-card>

                <v-spacer />
            </v-flex>
            <v-spacer />

            <v-flex align-center xs12 md6>
                <!-- At the moment, topics are shown in a data table with rows that contain a topic's name and number of articles. Datatables allow us with a lot of options for sorting and presenting data, and are more scalable for different screen resolutions than other data presentation methods -->
                <v-data-table :mobile-breakpoint="0" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :headers="headers" :items="topics" :search="search">
                    <template v-slot:item="{ item }">
                        <tr @click="rowClicked(item)">
                            <td>{{item.name}}</td>
                            <td>{{item.name}}</td>
                        </tr>
                    </template>
                </v-data-table>
            </v-flex>

            <!-- This is only ever opened when popup=true. Selecting a row will open the Popup component, and when the component is closed (by pressing close, or clicking off of the popup), that component emits a signal that sets popup=false, thus closing the popup -->
            <Popup v-model=" popup" />
            <v-col />
        </v-layout>
    </template>
</div>
</template>

<script>
import Popup from "../components/common/Popup";
import HelpTopics from "../components/common/HelpTopics";

import ALL_TOPICS from '../graphql/topics.gql'

import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

export default {
    name: "Topics",
    components: {
        Popup,
        HelpTopics
    },

    data: () => ({
        popup: false,
        start_date: '',
        end_date: '',
        dates: [],

        menu: false,
        search: '',
        media: '',
        sortBy: 'articles',
        sortDesc: true,

        headers: [{
                text: '# Articles',
                value: 'articles',
                width: "30%",
                align: 'center',
            },
            {
                text: 'Topic',
                value: 'topic',
                width: "100%",
                align: 'center',

            }
        ],
        topics: []
    }),

    apollo: {
        topics: {
            query: ALL_TOPICS,
            update: data => data.allTopics.nodes
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
            'emptySelected',
            'setSelected',
            'saveTrend',
            'deleteTrend',
        ]),
        formatDate(date) {
            let month = `${date.getMonth() + 1}`;
            let day = `${date.getDate()}`;
            const year = date.getFullYear();
            if (month.length < 2) month = `0${month}`;
            if (day.length < 2) day = `0${day}`;
            return [year, month, day].join('-');
        },
        rowClicked(row) {
            this.open(row.topic)
            console.log(row);
        },
        open(topic) {
            this.popup = true
            this.openTopic(topic)
        },
        saveDates() {
            this.$refs.menu.save(this.dates)
            if (this.dates[0] < this.dates[1]) {
                this.start_date = this.dates[0]
                this.end_date = this.dates[1]
            } else {
                this.start_date = this.dates[1]
                this.end_date = this.dates[0]
            }
            this.dates = [this.start_date, this.end_date]
        }
    },
    computed: {
        ...mapState(['current_topic', 'saved', 'popups', 'selected', 'related']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getSaved', 'getRelated', 'getPopups']),

        todaysDate() {
            const today = new Date();
            return this.formatDate(today);
        },
        dateRange() {
            return this.dates.join(' to ')
        },
    },
}
</script>

<style scoped>
td {
    text-align: center !important;
}

.list-title {
    font-size: 16px !important;
}

.item {
    margin: 5px;
    border-radius: 4px;
}

.item:hover {
    background: ghostwhite;
}
</style>
