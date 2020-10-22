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
                <v-card flat tile width='95%'>
                    <v-text-field v-model="search" prepend-icon="mdi-magnify" label="Search for a topic" />
                </v-card>
                <v-card flat tile width='95%'>
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
                <v-card flat tile>
                    <v-list flat rounded dense>
                        <v-list-group value="true" color="none">
                            <template v-slot:activator>
                                <v-list-item-content>
                                    <v-list-item-title class='font-weight-light list-title'>Selected Topics</v-list-item-title>
                                </v-list-item-content>
                            </template>
                            <v-list-item-group color="none">
                                <v-list-item class='item' v-for="item in getSelected" :key="item">

                                    <v-list-item-title @click='open(item)' v-text="item"></v-list-item-title>
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
                                <v-list-item class='item' v-for="item in getRelated" :key="item">

                                    <v-list-item-title @click='open(item)' v-text="item"></v-list-item-title>
                                    <v-btn icon @click='addSelected(item)'>
                                        <v-icon color="grey lighten-1">mdi-plus-circle</v-icon>
                                    </v-btn>
                                </v-list-item>
                            </v-list-item-group>
                        </v-list-group>
                    </v-list>

                    <template v-if="!$auth.loading & $auth.isAuthenticated">
                        <v-list flat rounded dense>
                            <v-list-group color="none">
                                <template v-slot:activator>
                                    <v-list-item-content>
                                        <v-list-item-title class='font-weight-light list-title'>Saved Trends</v-list-item-title>
                                    </v-list-item-content>
                                </template>
                                <v-list-item-group color="none">
                                    <v-list-item class='item' v-for="config in getSaved" :key="config" @click="setSelected(config.topics)">

                                        <v-list-item-title v-text=" config.title">
                                        </v-list-item-title>

                                    </v-list-item>
                                </v-list-item-group>
                            </v-list-group>

                            <template>
                                <v-row justify="center">
                                    <v-dialog v-model="dialog" max-width="600px" max-height="100px">
                                        <template v-slot:activator="{ on, attrs }">
                                            <v-btn width=90% rounded depressed v-bind="attrs" v-on="on">Save Trend Selection</v-btn>
                                        </template>
                                        <v-card>
                                            <v-card-title>
                                                <span class="headline">Save Trend Selection</span>
                                            </v-card-title>
                                            <v-card-text>
                                                <v-text-field v-model='name' label="Enter a name for your selection" required></v-text-field>
                                            </v-card-text>
                                            <v-card-actions>
                                                <v-spacer></v-spacer>
                                                <v-btn depressed rounded @click="dialog = false">
                                                    Close
                                                </v-btn>
                                                <v-btn depressed rounded @click="saveTrendSelection(name)">
                                                    Save
                                                </v-btn>
                                            </v-card-actions>
                                        </v-card>
                                    </v-dialog>
                                </v-row>
                            </template>
                        </v-list>
                    </template>
                </v-card>
            </v-flex>
            <v-spacer />

            <v-flex align-center xs12 md6>
                <!-- This is where the trends graph will go -->

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
    name: "Trends",
    components: {
        Popup,
    },

    data: () => ({

        dialog: false,
        popup: false,
        start_date: '',
        end_date: '',
        dates: [],

        menu: false,
        search: '',
        name: '',
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
            'closeTopic',
            'emptySelected',
            'setSelected',
            'saveTrend'
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
        },
        saveTrendSelection(name) {
            this.dialog = false
            this.saveTrend(name)

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
        ...mapState(['saved', 'popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getSaved', 'getRelated']),
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
