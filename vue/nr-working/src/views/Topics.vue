<template>
<div class="topics">
    <h1 class="subheading grey--text">Topics</h1>

    <template>
        <v-spacer />

        <v-layout wrap>
            <v-spacer />

            <v-flex xs12 md3>
                <v-text-field prepend-icon="mdi-magnify" label="Search" single-line hide-details @input="filterSearch"> </v-text-field>

                <v-text-field prepend-icon="mdi-book-open-variant" label="Media Outlet" single-line hide-details @input="filterMedia"></v-text-field>

                <template>
                    <v-row>
                        <v-col>
                            <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="date" transition="scale-transition" offset-y min-width="290px">
                                <template v-slot:activator="{ on, attrs }">
                                    <v-text-field v-model="dateRangeText" label="Date Range" prepend-icon="mdi-calendar" v-bind="attrs" v-on="on"></v-text-field>
                                </template>
                                <v-date-picker v-model="dates" range :show-current='true' @input:>
                                    <v-spacer></v-spacer>
                                    <v-btn text color="primary" @click="menu = false">
                                        Cancel
                                    </v-btn>
                                    <v-btn text color="primary" @click="$refs.menu.save(dates)">
                                        OK
                                    </v-btn>
                                </v-date-picker>
                            </v-menu>
                        </v-col>

                    </v-row>
                </template>
            </v-flex>

            <v-spacer />

            <v-flex xs12 md6>
                <v-data-table sortable='false' disable-sort="true" v-model="selected" :headers="headers" :items="rows" :pagination.sync="pagination" item-key="name" :rows-per-page-items="[-1]" :search="filters" :custom-filter="customFilter" @click:row="popup=true" />
            </v-flex>
            <Popup v-model="popup" />
            <v-col />

        </v-layout>
        <v-spacer />
        <v-flex>

            <v-card>
                <v-card-title primary-title>
                    <h3>Filters log:</h3>
                </v-card-title>
                <ul>
                    {{filters}}
                </ul>
            </v-card>
        </v-flex>

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
        dateRangeText() {
            return this.dates.join(' ~ ')
        },
    },
    data: () => ({
        dates: ['', ''],
        popup: false,

        menu: false,
        filters: {
            search: '',
            media: '',
            dates: ['', '']
        },
        media: ['ABC', 'The Guardian', 'The New York Times'],

        pagination: {
            sortBy: 'articles'
        },
        selected: [],
        headers: [{
                text: 'Articles',
                value: 'articles',
                width: "30%",
                align: 'center',
                sortable: false
            },
            {
                text: 'Topic',
                value: 'topic',
                width: "100%",
                align: 'center',
                sortable: false,
            }
        ],
        rows: [{
                value: false,
                articles: '5',
                topic: 'Coronavirus'
            },
            {
                value: false,
                articles: '4',
                topic: 'U.S. Election'
            },
            {
                value: false,
                articles: '3',
                topic: 'Californian Bushfires',
            },
            {
                value: false,
                articles: '2',
                topic: 'New Zealand'
            },
            {
                value: false,
                articles: '1',
                topic: 'Melbourne'
            },
        ]
    }),
    methods: {
        customFilter(items, filters, filter, headers) {
            // Init the filter class.
            const cf = new this.$MultiFilters(items, filters, filter, headers);
            // Use regular function(),
            // arrow functions does not allow context binding.
            // Register the global standard filter.
            cf.registerFilter('search', function (searchWord, items) {
                if (searchWord.trim() === '') return items;
                return items.filter(item => {
                    return item.name.toLowerCase().includes(searchWord.toLowerCase());
                }, searchWord);
            });
            cf.registerFilter('media', function (searchMedia, items) {
                if (searchMedia.trim() === '') return items;
                return items.filter(item => {
                    return item.name.toLowerCase().includes(searchMedia.toLowerCase());
                }, searchMedia);
            });
            // Use regular function(),
            // arrow functions does not allow context binding.
            // Register "start_date" filter.
            cf.registerFilter('added_by', function (added_by, items) {
                // If the filter has not been applied yet
                // just return all available items.
                if (added_by.trim() === '') return items;
                // Compare each item added_by and just return the matching ones.
                return items.filter(item => {
                    return item.added_by.toLowerCase() === added_by.toLowerCase();
                }, added_by);
            });
            // Use regular function(),
            // arrow functions does not allow context binding.
            // Register "end_date" filter.
            cf.registerFilter('end_date', function (end_date, items) {
                // If the filter has not been applied yet
                // just return all available items.
                if (end_date === null) return items;
                // Compare each item end_date and just return the matching ones.
                return items.filter(item => {
                    return item.birth_date <= end_date;
                }, end_date);
            });
            // Its time to run all created filters.
            // Will be executed in the order thay were defined.
            return cf.runFilters();
        },
        /**
         * Toggle selected items with the master checkbox.
         */
        toggleAll() {
            if (this.selected.length) {
                this.selected = [];
            } else {
                this.selected = this.rows.slice();
            }
        },
        /**
         * Column shorting.
         *
         * @param column
         */
        changeSort(column) {
            if (this.pagination.sortBy === column) {
                this.pagination.descending = !this.pagination.descending;
            } else {
                this.pagination.sortBy = column;
                this.pagination.descending = false;
            }
        },
        /**
         * Handler when user input something at the "Filter" text field.
         */
        filterSearch(val) {
            this.filters = this.$MultiFilters.updateFilters(this.filters, {
                search: val
            });
        },
        /**
         * Handler when user  select some author at the "Author" select.
         */
        filterMedia(val) {
            this.filters = this.$MultiFilters.updateFilters(this.filters, {
                media: val
            });
        },
        /**
         * Handler when select a date on "From" date picker.
         */
        filterDates(val) {
            this.filters = this.$MultiFilters.updateFilters(this.filters, {
                dates: val
            });
        }
    }
};
</script>
