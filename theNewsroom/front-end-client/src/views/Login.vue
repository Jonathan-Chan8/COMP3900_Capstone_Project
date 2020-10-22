<template>
<div class="home">
    <h1 class="subheading grey--text">Login</h1>
</div>
</template>

<script>
    export default {
        data() {
            return {

            }
        }
    }
</script>

<style>
</style>

<template>
    <div class="topics">
        <h1 class="body grey--text text-center"></h1>

        <template>
            <v-spacer />

            <v-layout wrap>
                <v-spacer />

                <v-flex xs=10 md=10 sm=10>
                    <!-- Really, these filters wont actually filter the datatable, but rather will be used as input to our db query, thus changing the reuslts of the topics list returned by the database -->

                    <!-- For now this filters the datatable, really we want it to produce a popup with possible matches on 'enter', and selecting a match will produce the corresponding topic popup. This field ought to be in the same position of the page on both Topics and Trends, to show continuity -->
                    <v-card flat tile width='100%'>
                        <v-text-field v-model="search" prepend-icon="mdi-magnify" label="Search for a topic" />
                    </v-card>

                    <v-card flat tile width='100%'>

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
                    <v-card flat tile width='100%'>
                        <v-text-field v-model="media" prepend-icon="mdi-book-open-variant" label="Filter by media outlet" single-line hide-details></v-text-field>
                    </v-card>

                </v-flex>

                <v-spacer />

                <v-flex align-center xs=10 md=10>
                    <v-data-table :mobile-breakpoint="0" :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :headers="headers" :items="topics" :search="search">

                        <template v-slot:item="{ item }">

                            <tr @click="rowClicked(item)">
                                <td>{{item.articles}}</td>
                                <td>{{item.topic}}</td>
                            </tr>
                        </template>

                    </v-data-table>

                </v-flex>
                <Popup v-model="popup" />
                <v-col />
            </v-layout>
        </template>
    </div>
</template>
