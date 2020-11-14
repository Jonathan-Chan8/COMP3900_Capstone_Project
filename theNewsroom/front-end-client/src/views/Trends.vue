<template>
<div class="trends">
    <template>
        <v-container fluid>

            <v-layout wrap>
                <v-flex xs12 md4>
                    <!-- Really, these filters wont actually filter the datatable, but rather will be used as input to our db query, thus changing the reuslts of the topics list returned by the database -->

                    <!-- For now this filters the datatable, really we want it to produce a popup with possible matches on 'enter', and selecting a match will produce the corresponding topic popup. This field ought to be in the same position of the page on both Topics and Trends, to show continuity -->
                    <v-card flat tile width='100%'>
                        <v-list ripple=false expand flat rounded dense>

                            <!-- Search, calendar and media are subgroups in a the group Filters, allowing us to easily modify this entire list as a single element -->
                            <v-list-group value="true" color="none">

                                <template v-slot:activator>
                                    <v-list-item-content>
                                        <v-list-item-title class='font-weight-light list-title'>Filters</v-list-item-title>
                                    </v-list-item-content>
                                </template>
                                <!-- Search -->
                                <v-list-item>
                                    <v-text-field @keyup.enter.native="searchTopic" dense rounded filled v-model="keyword" append-icon="mdi-magnify" label="Search for a topic" single-line hide-details />
                                    <Search v-model="search" />
                                </v-list-item>
                                <!-- Calendar -->
                                 <v-list-item>
                                    <v-menu ref="menu" v-model="menu" :close-on-content-click="false" :return-value.sync="dates" transition="scale-transition" offset-y min-width="290px">
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
                            </v-list-group>
                            <!-- Selected, Related and Saved topics are also presented as groups in the List, allowing us to open and close them easily to show their internal components. Selected is set to true so that it is shown automatically, whilst the others are closed by default -->
                            <v-list-group value="true" color="none">
                                <template v-slot:activator>
                                    <v-list-item-content>
                                        <v-list-item-title class='font-weight-light list-title'>Selected Topics</v-list-item-title>
                                    </v-list-item-content>
                                </template>
                                <v-list-item-group value="true" color="none">
                                    <v-list-item class='item' v-for="(item, index) in getSelected" :key="index" >
                                        <v-list-item-title @click='open(item)' v-text="item.name" />
                                        <v-icon v-if='index == 0' color="#FF9D00">mdi-circle</v-icon>
                                        <v-icon v-if='index == 1' color='#66DB00'>mdi-circle</v-icon>
                                        <v-icon v-if='index == 2' color="#FF42DC">mdi-circle</v-icon>
                                        <v-icon v-if='index == 3' color="#0096DB">mdi-circle</v-icon>
                                        <v-icon v-if='index == 4' color="#DB0004">mdi-circle</v-icon>
                                        <v-btn icon @click='removeSelected(item)'>
                                            <v-icon color="grey lighten-1">mdi-minus-circle</v-icon>
                                        </v-btn>
                                    </v-list-item>
                                </v-list-item-group>
                            </v-list-group>
                            <v-list-group color="none">
                                <template v-slot:activator>
                                    <v-list-item-content>
                                        <v-list-item-title class='font-weight-light list-title'>Related Topics</v-list-item-title>
                                    </v-list-item-content>
                                </template>
                                <v-list-item-group color="none">
                                    <v-list-item  class='item' v-for="item in related" :key="item">
                                        <v-list-item-title @click='open(item)' v-text="item.name" />
                                        <v-btn icon @click='addSelected(item)'>
                                            <v-icon color="grey lighten-1">mdi-plus-circle</v-icon>
                                        </v-btn>
                                    </v-list-item>
                                </v-list-item-group>
                            </v-list-group>
                            <template v-if="!$auth.loading & $auth.isAuthenticated">
                                <v-list-group color="none">
                                    <template v-slot:activator>
                                        <v-list-item-content>
                                            <v-list-item-title class='font-weight-light list-title'>Saved Trends</v-list-item-title>
                                        </v-list-item-content>
                                    </template>
                                    <v-list-item-group color="none">
                                        <v-list-item class='item' v-for="config in getSaved" :key="config" @click="setSelected(config.topics)">
                                            <v-list-item-title v-text=" config.title" />
                                        </v-list-item>
                                    </v-list-item-group>
                                </v-list-group>

                            </template>

                            <v-list-item>
                                <v-spacer />
                                <SaveTrend v-if="!$auth.loading & $auth.isAuthenticated" />
                                <!--v-btn rounded depressed @click="updateTrends"-->
                                    <!--Refresh </=-v-btn>-->
                                <v-btn rounded depressed @click="reset">
                                    Reset </v-btn>
                                <HelpTrends />

                            </v-list-item>
                        </v-list>
                    </v-card>
                </v-flex>
                <v-spacer />

                <v-flex align-center xs12 md8>
                    <template>
                        <div>
                            <apexchart type="line" :options="options" :series="trends_graph"></apexchart>
                        </div>
                    </template>
                </v-flex>

                <!-- Same as on Home and Topics, this is only shown when popup = true and is closed when popup = false -->
                <Popup v-model="popup" />

                <v-col />
            </v-layout>
        </v-container>
        {{dates}}
                <v-divider/>

        {{start_date}}
        {{end_date}}

        <v-divider/>

        {{date}}
                <v-divider/>

                <v-divider/>
{{trends_graph}}

        <v-divider/>

   


    </template>
</div>
</template>

<script>
import Popup from "../components/common/Popup";
import SaveTrend from "../components/common/SaveTrend";
import HelpTrends from "../components/common/HelpTrends";
import Search from "../components/common/Search"
import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';
import ALL_TOPICS_WITH_FILTER from '../graphql/TopicsAndArticleCount.gql'
import TOPIC_ARTICLES_DATE from '../graphql/TopicArticlesByDate.gql'
export default {
    name: "Trends",
    components: {
        Popup,
        SaveTrend,
        HelpTrends,
        Search
    },
    data: () => ({
        el: '#app',
        mounted: function() {
            //this.updateTrends()
            console.log("Mounted!")
        },
        options: {
            stroke: {
                curve: 'smooth',
            },
            colors: [
                '#FF9D00', '#66DB00', '#FF42DC', '#0096DB', '#DB0004', 
            ],
            xaxis: {
                type: 'datetime'
            },
            markers: {
                size: 0,
                hover: {
                    sizeOffset: 6
                }
            },
            grid: {
                borderColor: '#f1f1f1',
            },
            legend: {
                horizontalAlign: 'right',
                position: 'top',
                onItemHover: {
                    highlightDataSeries: true
                },
            },
            chart: {
                selection: {
                    enabled: true
                },
                toolbar: {
                    show: false,
                    offsetX: 0,
                    offsetY: 0,
                    tools: {
                        download: true,
                        selection: false,
                        zoom: false,
                        zoomin: true,
                        zoomout: true,
                        pan: false,
                        reset: false,
                        customIcons: []
                    },
                    export: {
                        csv: {
                            filename: undefined,
                            columnDelimiter: ',',
                            headerCategory: 'category',
                            headerValue: 'value',
                            dateFormatter(timestamp) {
                                return new Date(timestamp).toDateString()
                            }
                        }
                    },
                    autoSelected: 'zoom'
                },
            },
        },
        search: false,
        save: false,
        popup: false,
        start_date: null,
        end_date: null,
        dates: [],
        keyword: '',
        menu: false,
        related: [],
        //trends: '',
        date: null,
        topic_id: null,
        trends_graph: [],
        skipQuery: true,
    }),
    watch: {
        getSelected: {
            handler: function() {
                // this.$apollo.queries.related.refresh().
                //this.updateTrends()
                console.log('Related topics and Trends graph refreshed')
            },
            // deep: true,
            immediate: true

        },
    },
    apollo: {
        related: { query: ALL_TOPICS_WITH_FILTER, variables() { return {
                                   limit: 5
                }
            },
            update(data) {
                return data.allTopics.nodes;
            }
        },
        trends: {
            query: TOPIC_ARTICLES_DATE,
            variables() {
                if (this.start_date == null) {
                    this.end_date = new Date()
                    this.start_date = new Date()
                    this.start_date.setMonth(this.end_date.getMonth() - 1)

                    this.start_date = this.start_date.toISOString().slice(0, 10)                    
                    this.end_date = this.end_date.toISOString().slice(0, 10)
                }
              
                return {
                    topicId: this.topic_id,
                    startdate: this.start_date,
                    enddate: this.end_date
                }
            },
            update(data) {
                console.log(this.topic_id, this.start_date, this.end_date)
                return data.aggregatearticlecountbydays.nodes
            },
            skip() {
                return this.skipQuery
            },
            options: {
                awaitFetchQueries: false,
                fetchPolicy: 'cache-first',
                forceFetch: false

            }
        }
    },
    methods: {
/*         updateTrends() {
            this.trends_graph = []
            
            var i
            for (i = 0; i < this.getSelected.length; i++) {
                this.topic_id =  this.getSelected[i].id
                
                this.$apollo.queries.trends.skip = false
                this.$apollo.queries.trends.refetch()

                var data_series = this.trends.map(el => ({
                    x: el.x,
                    y: el.y
                }))

                // var date = new Date(this.start_date)
                // while (date <= this.end_date) {
                //     let index = this.trends.findIndex(item => item.x == date)
                //     if (index == -1) {
                //         data_series.push({
                //         x: date.toISOString().slice(10),
                //         y: 0
                //     })
                //     }
                //     var next = new Date(date)
                //     next.setDate(next.getDate()+1)
                //     date = next
                // }
                
                this.trends_graph.push({
                    name: this.getSelected[i].name,
                    data: data_series
                })
            }
        }, */
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
            'saveTrend',
            'searchTopicKeyword'
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
            this.start_date = new Date(this.start_date)
            this.end_date = new Date(this.end_date)
            //this.updateTrends()
        },
        saveTrendSelection(name) {
            if (this.name.length > 3 && this.name.length <= 20 && this.selected.length > 0) {
                this.dialog = false
                this.saveTrend(name)
            }
        },
        searchTopic() {
            this.search = true
            this.searchTopicKeyword(this.keyword)
        },
        reset() {
            this.dates = []
            this.start_date = null
            this.end_date = null
            this.media = ''
            this.emptySelected()
        }
    },
    computed: {
        ...mapState(['current_topic', 'current_article', 'saved', 'popups', 'selected', 'related']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getSaved', 'getRelated', 'getPopups']),
        todaysDate() {
            const today = new Date();
            return this.formatDate(today);
        },
        dateRange() {
            return this.dates.join(' to ')
        },
    }
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
    background: [];
}
.item:hover {
    background: ghostwhite;
}
</style>

