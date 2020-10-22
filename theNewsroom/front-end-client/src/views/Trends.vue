<template>
<div class="trends">
    <h1 class="body grey--text text-center"></h1>

    <template>
        <v-spacer />

        <v-layout wrap>
            <v-spacer />

            <v-flex xs10 md3>
                <!-- Really, these filters wont actually filter the datatable, but rather will be used as input to our db query, thus changing the reuslts of the topics list returned by the database -->

                <!-- For now this filters the datatable, really we want it to produce a popup with possible matches on 'enter', and selecting a match will produce the corresponding topic popup. This field ought to be in the same position of the page on both Topics and Trends, to show continuity -->
                <v-card flat tile width='80%'>
                    <v-text-field v-model="search" prepend-icon="mdi-magnify" label="Search for a topic" />
                </v-card>
                <v-card flat tile width='80%'>
                    <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="date" transition="scale-transition" offset-y min-width="290px">
                        <template v-slot:activator="{ on, attrs }">
                            <v-text-field v-model="dateRange" label="Select time period" prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                        </template>
                        <v-date-picker v-model="dates" :max='todaysDate' range no-title scrollable>
                            <v-spacer></v-spacer>
                            <v-btn text color="primary" @click="saveDates">
                                OK
                            </v-btn>
                        </v-date-picker>
                    </v-menu>
                </v-card>
                <v-card flat tile width='90%'>
                    <v-list flat rounded dense>
                        <v-list-group value="true" color="none">
                            <template v-slot:activator>
                                <v-list-item-content>
                                    <v-list-item-title class='font-weight-light list-title'>Selected Topics</v-list-item-title>
                                </v-list-item-content>
                            </template>
                            <v-list-item-group color="none">
                                <v-list-item class="item" v-for="item in getSelected" :key="item">
                                    <v-list-item-title @click='open(item)' v-text="item">
                                    </v-list-item-title>
                                    <v-btn icon @click='removeSelected(item)'>
                                        <v-icon color="grey lighten-1">mdi-minus-circle</v-icon>
                                    </v-btn>
                                </v-list-item>
                            </v-list-item-group>
                        </v-list-group>
                    </v-list>
                    <v-list flat rounded dense>
                        <v-list-group color="none">
                            <template v-slot:activator>
                                <v-list-item-content>
                                    <v-list-item-title class='font-weight-light list-title'>Related Topics</v-list-item-title>
                                </v-list-item-content>
                            </template>
                            <v-list-item-group color="none">
                                <v-list-item class='item' v-for="item in getRelated" :key="item.topic">

                                    <v-list-item-title @click='open(item.topic)' v-text="item.topic"></v-list-item-title>
                                    <v-btn icon @click='addSelected(item.topic)'>
                                        <v-icon color="grey lighten-1">mdi-plus-circle</v-icon>
                                    </v-btn>
                                </v-list-item>
                            </v-list-item-group>
                        </v-list-group>
                    </v-list>
                </v-card>
            </v-flex>
            <v-spacer />

            <v-flex align-center xs12 md6>
                <!-- This is where the trends graph will go -->

            </v-flex>
            <Popup v-model="popup" />
            <v-col />
        </v-layout>
    </template>
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
        start_date: '',
        end_date: '',
        dates: [],

        menu: false,
        search: '',

        selected: [{
                articles: '908',
                topic: 'Coronavirus',
            },
            {
                articles: '1462',
                topic: 'U.S. Election',
            },
            {
                articles: '826',
                topic: 'Californian Bushfires',
            },
            {
                articles: '142',
                topic: 'New Zealand',
            },
            {
                articles: '637',
                topic: 'Melbourne',
            },
        ],
        related: [{
                articles: '341',
                topic: 'Scott Morrison',
            },
            {
                articles: '1004',
                topic: 'Iran',
            },
            {
                articles: '837',
                topic: 'Brexit',
            },
            {
                articles: '463',
                topic: 'Vaccine',
            },
            {
                articles: '1349',
                topic: 'ACT',

            }
        ],
    }),

    methods: {
        formatDate(date) {
            let month = `${date.getMonth() + 1}`;
            let day = `${date.getDate()}`;
            const year = date.getFullYear();
            if (month.length < 2) month = `0${month}`;
            if (day.length < 2) day = `0${day}`;
            return [year, month, day].join('-');
        },
        ...mapMutations([
            'addSelected',
            'removeSelected',
            'openTopic',
            'nextTopic',
            'previousTopic',
            'closeTopic'
        ]),
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
            // this.db = queryDB()
        }
    },
    computed: {
        todaysDate() {
            const today = new Date();
            return this.formatDate(today);
        },
        dateRange() {
            return this.dates.join(' to ')
        },
        ...mapState(['popup', 'popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected']),

        getRelated() {
            // This will actually query the db to get the top 5 related topics to the current selection, however for now this is simply hardcoded
            return this.related
        }
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
