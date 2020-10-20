<template>
<div class="topics">
    <h1 class="subheading grey--text">Topics</h1>

    <template>
        <v-spacer />

        <v-layout wrap>
            <v-spacer />

            <v-flex xs10 md3>
                <!-- Really, these filters wont actually filter the datatable, but rather will be used as input to our db query, thus changing the reuslts of the topics list returned by the database -->

                <v-text-field v-model="search" prepend-icon="mdi-magnify" label="Search" single-line hide-details></v-text-field>

                <v-text-field v-model="media" prepend-icon="mdi-book-open-variant" label="Media" single-line hide-details></v-text-field>

                <v-menu v-model="menu" :close-on-content-click="false" :nudge-right="40" transition="scale-transition" offset-y min-width="290px">
                    <template v-slot:activator="{ on, attrs }">
                        <v-text-field v-model="date" label="Start Date" prepend-icon="mdi-calendar" readonly v-bind="attrs" v-on="on"></v-text-field>
                    </template>
                    <v-date-picker no-title v-model="date" :max='todaysDate' @click="$refs.menu.save(date)" @input="menu=false"></v-date-picker>
                </v-menu>
            </v-flex>

            <v-spacer />

            <v-flex align-center xs12 md6>
                <v-data-table :mobile-breakpoint="0" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :headers="headers" :items="topics" :search="search" @click:row="popup=true" />

            </v-flex>
            <Popup v-model="popup" />
            <v-col />
        </v-layout>
    </template>
</div>
</template>

<script>
import Popup from "../components/common/Popup";

export default {
    name: "Topics",
    components: {
        Popup
    },
    computed: {
        todaysDate() {
            const today = new Date();
            return this.formatDate(today);
        },
        dateRange() {
            return this.todaysDate() + '-' + this.formatDate(this.start_date)
        },
    },

    data: () => ({
        popup: false,

        date: '',
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
                date: '2020-10-08'
            },
            {
                articles: '1462',
                topic: 'U.S. Election',
                date: '2020-10-02'
            },
            {
                articles: '826',
                topic: 'Californian Bushfires',
                date: '2020-10-2'
            },
            {
                articles: '142',
                topic: 'New Zealand',
                date: '2020-10-17'
            },
            {
                articles: '637',
                topic: 'Melbourne',
                date: '2020-10-12'
            }, {
                articles: '341',
                topic: 'Scott Morrison',
                date: '2020-10-14'
            },
            {
                articles: '1004',
                topic: 'Iran',
                date: '2020-10-03'
            },
            {
                articles: '837',
                topic: 'Brexit',
                date: '2020-10-05'
            },
            {
                articles: '463',
                topic: 'Vaccine',
                date: '2020-10-16'
            },
            {
                articles: '1349',
                topic: 'ACT',
                date: '2020-10-13'
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

    }
}
</script>
