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
                        <v-list-group value="true" color="none">
                            <template v-slot:activator>
                                <v-list-item-content>
                                    <v-list-item-title class='font-weight-light list-title'>Filters</v-list-item-title>
                                </v-list-item-content>
                            </template>
                            <v-list-item>
                                <v-text-field dense rounded filled v-model="search" append-icon="mdi-magnify" label="Search for a topic" single-line hide-details />

                            </v-list-item>

                            <v-list-item>

                                <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="date" transition="scale-transition" offset-y min-width="290px">
                                    <template v-slot:activator="{ on, attrs }">
                                        <v-text-field dense rounded filled v-model="dateRange" label="Select time period" append-icon="mdi-calendar" single-line hide-details readonly v-bind="attrs" v-on="on"></v-text-field>
                                    </template>
                                    <v-date-picker v-model="dates" :max='todaysDate' range no-title scrollable>
                                        <v-spacer></v-spacer>
                                        <v-btn text color="primary" @click="saveDates">
                                            OK
                                        </v-btn>
                                    </v-date-picker>
                                </v-menu>
                            </v-list-item>

                            <v-list-item>

                                <v-text-field dense rounded filled v-model="media" append-icon="mdi-book-open-variant" label="Filter by media outlet" single-line hide-details></v-text-field>
                            </v-list-item>
                        </v-list-group>
                    </v-list>

                </v-card>

                <v-spacer />
            </v-flex>
            <v-spacer />

            <v-flex align-center xs12 md6>

                <v-data-table :mobile-breakpoint="0" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :headers="headers" :items="topics" :search="search">

                    <template v-slot:item="{ item }">

                        <tr @click="rowClicked(item)">
                            <td>{{item.articles}}</td>
                            <td>{{item.topic}}</td>
                        </tr>
                    </template>

                </v-data-table>

            </v-flex>
            <Popup v-model=" popup" />
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
        medias: ['ABC', 'The Guardian', 'The New York Times'],
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
        topics: [{
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
            }, {
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
            },
        ]
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
        todaysDate() {
            const today = new Date();
            return this.formatDate(today);
        },
        dateRange() {
            return this.dates.join(' to ')
        },
        ...mapState(['popup', 'popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected']),
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
