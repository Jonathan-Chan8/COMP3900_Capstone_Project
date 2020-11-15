<template>
<div class="trends">
    <template>
        <v-container fluid>

            <v-layout wrap>
                <v-flex xs12 md4>
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
                                        <v-icon v-if='index == 0' color="#FF42DC">mdi-circle</v-icon>
                                        <v-icon v-if='index == 1' color="#0096DB">mdi-circle</v-icon>
                                        <v-icon v-if='index == 2' color="#FF9D00">mdi-circle</v-icon>
                                        <v-icon v-if='index == 3' color='#66DB00'>mdi-circle</v-icon>
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
                                    <v-list-item  class='item' v-for="item in related_topics" :key="item.id">
                                        <v-list-item-title @click='open(item)' v-text="item.name" />
                                        <v-btn icon @click='add(item)'>
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
                                        <v-list-item class='item' v-for="config in getSaved" :key="config.title" @click="setSelected(config.topics)">
                                            <v-list-item-title v-text=" config.title" />
                                        </v-list-item>
                                    </v-list-item-group>
                                </v-list-group>

                            </template>

                            <v-list-item>
                                <v-spacer />
                                <SaveTrend v-if="!$auth.loading & $auth.isAuthenticated" />
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
                            <apexchart type="line" :options="options" :series="graph"></apexchart>
                        </div>
                    </template>
                </v-flex>

                <Popup v-model="popup" />
                <Replace v-model="replace" />
                <v-col />
            </v-layout>
        </v-container>
    </template>
    {{getSelected}}


</div>
</template>

<script>
import Popup from "../components/common/Popup";
import Replace from "../components/common/Replace";
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
        Search,
        Replace
    },
    data: () => ({
        el: '#app',
        
        options: {
            stroke: {
                curve: 'smooth',
            },
            colors: [
                '#FF42DC', '#0096DB', '#FF9D00', '#66DB00', '#DB0004', 
            ],
            xaxis: {
                type: 'datetime'
            },
            yaxis: {
                label: {
                    text: 'Number of Articles'
                },
                min: 0,
                forceNiceScale: true
            },
            tooltip: {
                enabled: true,
                followCursor: true,
                shared: true,

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
                horizontalAlign: 'center',
                position: 'bottom',
                onItemHover: {
                    highlightDataSeries: true
                },
            },
            chart: {
                selection: {
                    enabled: true
                },
                toolbar: {
                    show: true,
                    offsetX: 0,
                    offsetY: 0,
                    tools: {
                        download: true,
                        selection: false,
                        zoom: false,
                        zoomin: true,
                        zoomout: true,
                        pan: true,
                        reset: true,
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
        related_topics: [],
        result: null,
        trends: [],
        date: null,
        topic_id: null,
        graph: [],
        skipQuery: true,
        replace: false,
    }),
    watch: {
        getSelected: {
            handler: function() {
            console.log('Selected watcher start')
            this.callTrends()
            this.checkRemove()

            if (this.getSelected.length == 0) {
                this.graph = []
            }
            console.log('Selected watcher end')
            },
        },
        result: {
            handler: function() {
                console.log('Result watcher start')
                let index = this.trends.findIndex(item => item.name == this.result.name)
                if (index == -1 ) {
                    console.log('push')
                    this.trends.push(this.result)
                } else {
                    console.log('replace')
                    this.trends[index] = this.result
                    console.log('replace 2')
                }
                this.checkRemove()
                console.log('Result watcher end')
            },
        }
    },
    apollo: {
        related_topics: {
            query: ALL_TOPICS_WITH_FILTER,
            variables() {
                return {
                    limit: 5
                }
            },
            update(data) {
                return data.allTopics.nodes;
            }
        },
        result: {
            query: TOPIC_ARTICLES_DATE,
            variables() {
                return {
                    topicId: this.topic_id,
                    startdate: this.start_date,
                    enddate: this.end_date
                }
            },
            update(data) {
                console.log(this.topic_id, this.start_date, this.end_date)
                return {
                    name: data.topicById.name, 
                    data: data.aggregatearticlecountbydays.nodes.map(a => ({
                        x: a.x,
                        y: a.y
                    }))
                }
            },
            skip() {
                return this.skipQuery
            },
            options: {
                // fetchPolicy: 'cache-first',
            }
        },
    },
    methods: {
        checkRemove() {
            if (this.getSelected.length != this.trends.length){
                var i
                for (i = 0; i < this.trends.length; i++) {
                    let index = this.getSelected.findIndex(item => item.name == this.trends[i].name)
                    if (index == -1) {
                        this.trends.splice(index, 1)
                    }
                }
            }
        },
        async callTrends() {
            var i
            for (i = 0; i < this.getSelected.length; i++) {
                this.topic_id =  this.getSelected[i].id
                this.$apollo.queries.result.skip = false
                await this.$apollo.queries.result.refetch()
                console.log('Result fetched')
            }
            this.graph = this.trends.map(a => a)
            console.log('Exiting call')
        },
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
            'setSelected',
            'emptySelected',
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
            this.callTrends()
        },
        // saveTrendSelection(name) {
        //     if (this.name.length > 3 && this.name.length <= 20 && this.selected.length > 0) {
        //         this.dialog = false
        //         this.saveTrend(name)
        //     }
        // },
        // async saveTrendSelection(configName) {
        //     var usrId = this.$auth.user.sub
        //     await this.$apollo.mutate({
        //         mutation: CREATE_USER_CONFIG,
        //         variables: {
        //             configName,
        //             usrId
        //         }
        //     })
        //     var usrConfigId = this.create_user_config

        //     var i
        //     for (i = 0; i < this.getSelected.length; i++) {
        //         var topicId = this.getSelected[i].id
        //         await this.$apollo.mutate({
        //         mutation: CREATE_TOPIC_CONFIG,
        //             variables: {
        //                 usrConfigId,
        //                 topicId
        //             }
        //         })
        //     }
        // },
        searchTopic() {
            if (this.keyword != '') {
                this.search = true
                this.searchTopicKeyword(this.keyword)
            }
        },
        reset() {
            console.log('Reset')
            this.dates = []
            this.end_date = new Date()
            this.start_date = new Date()
            this.start_date.setMonth(this.end_date.getMonth() - 1)

            this.start_date = this.start_date.toISOString().slice(0, 10)                    
            this.end_date = this.end_date.toISOString().slice(0, 10)
            this.dates = [this.start_date, this.end_date]
            this.emptySelected()
        },
        add(topic) {
            if (this.numSelected == 5) {
                this.replace = true
            } else {
                this.addSelected(topic)
            }
        }
    },
    mounted: function() {
        if (this.start_date == null) {
            this.end_date = new Date()
            this.start_date = new Date()
            this.start_date.setMonth(this.end_date.getMonth() - 1)
            this.start_date = this.start_date.toISOString().slice(0, 10)                    
            this.end_date = this.end_date.toISOString().slice(0, 10)
        }
        this.dates = [this.start_date, this.end_date]
        this.callTrends()
        console.log("Mounted!")
    },
    computed: {
        ...mapState(['saved', 'selected', 'related']),
        ...mapGetters(['numSelected', 'getSelected', 'getSaved', 'getRelated']),
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
