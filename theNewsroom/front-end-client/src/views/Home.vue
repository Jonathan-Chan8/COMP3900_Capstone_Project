<template>
<div class="home">
    <v-container fluid>
        <v-col>
            <v-list-item>
                <v-text-field @keyup.enter.native="searchTopic" dense rounded filled v-model="keyword" append-icon="mdi-magnify" label="Looking for a specific topic?" single-line hide-details />
                <Search v-model="search" />
            </v-list-item>
        </v-col>

        <v-row>
            <!-- Topic of the Day -->
            <v-col   cols="12" md='6'>
                <v-card  color='rgb(230, 235, 255)' class="flex-wrap text-justify justify-space-between" height="100%" width="100%" hover @click="open(topics[0])">
                    <v-card-title class="headline">Topic of the Day</v-card-title>
                    <v-spacer/>
                    <v-card-text class="text-center font-weight-bold" v-resize-text v-text='topics[0].name' />
                    <v-card-text class='text-center'> {{topics[0].topicofarticlesByTopicId.totalCount}} articles</v-card-text>
                </v-card>
                <Popup v-model="popup" />
            </v-col>

            <!-- Login/Register/Saved -->
            <v-col   cols="12" md='6'>
                <!-- Show login/register when user is not authenticated -->
                <v-card  color='rgb(230, 235, 255)' v-if="!$auth.loading && !$auth.isAuthenticated" class="flex-wrap text-justify justify-space-between" height="100%" width="100%" hover>
                    <v-card-title class="headline" v-text="unauth.title" />
                    <v-card-text >{{unauth.text}}</v-card-text>
                    <v-card-text class='text-center'> <strong>{{unauth.second_text}}</strong></v-card-text>
                </v-card>

                <!-- show saved/logout when user is authenticated -->
                <v-card  color='rgb(230, 235, 255)' v-else class="flex-wrap text-justify justify-space-between" height="100%" hover :to='saved.route'>
                    <v-card-title class="headline" v-text="saved.title" />
                    <v-card-text v-text='saved.text' />
                    <v-card-text class='text-center'> <strong>{{saved.second_text}}</strong></v-card-text>
                </v-card>
            </v-col>

            <!-- Topics/Trends -->
            <v-col dark v-for="card in cards" :key="card.id"   cols="12" md='6'>
                <v-card  color='rgb(230, 235, 255)' class=" flex-wrap text-justify justify-space-between" rounded height="100%" width="100%" hover :to='card.route'>
                    <v-card-title class="headline" v-text="card.title" />
                    <v-card-text> {{card.text}} </v-card-text>
                    <v-card-text class='text-center'> <strong>{{card.second_text}}</strong> </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</div>
</template>

<script>
import Popup from "../components/common/Popup";
import Search from "../components/common/Search";

import ALL_TOPICS_WITH_FILTER from '../graphql/TopicsAndArticleCount.gql'
import {
    mapMutations
} from 'vuex';

export default {
    name: "Home",
    components: {
        Popup,
        Search
    },

    data() {
        return {
            popup: false,
            auth: true,
            keyword: '',
            search: false,
            absolute: true,
            opacity: 10,
            overlay: false,
            unauth: {
                id: 'unreg',
                title: 'Log in for additional features!',
                text: ' Register an account or log in to get access to additional features, such as selecting more topics on your Trends graph and saving topics for later!',
                second_text: 'Click to Register or Log In!',

                route: '/register'
            },
            saved: {

                id: 'saved',
                title: 'My Saved Trends',
                text: 'Click here to view your saved trends, and explore how your selected topics are behaving!',
                second_text: 'Click to view your Saved Trends!',

                route: '/saved'
            },
            // totd: get_totd() ------ When we have connected to db
            totd: {
                id: 'totd',
                topic: 'Coronavirus',
                title: "Topic of the Day",
                text: 'We will have here some function to request the most popular topic in the last 24 hours, and clicking it will open the associated overlay.',
                route: ''
            },
            cards: [{
                    id: 'topics',
                    title: 'What is Topics?',
                    text: 'Sometimes, you just need to see the big picture. On the Topics page, you can explore the most popular news topics however you want. Adjust the time period, and filter by media outlets, to view which topics are the most prominent in the media landscape.',
                    second_text: 'Click to go to Topics!',

                    route: '/topics'
                },
                {
                    id: 'trends',
                    title: 'What is Trends?',
                    text: 'Looking to see how news topics change in relation to each other? Head to the Trends page to view the popularity of selected topics over time on a line graph. You can register an account for additional features, such as saving Trends configurations for later and selecting additional topics.',
                    second_text: 'Click to go to Trends!',
                    route: '/trends'
                }
            ],
            topics: []
        }
    },

    apollo: {
        topics: {
            query: ALL_TOPICS_WITH_FILTER,
            variables() {
                return {
                    limit: 2
                }
            },
            update(data) {
                return data.allTopics.nodes;
            }
        }
    },

    methods: {
        ...mapMutations([
            'openTopic',
            'searchTopicKeyword'

        ]),
        login() {
            this.$auth.loginWithPopup();
        },
        logout() {
            this.$auth.logout({
                returnTo: window.location.origin
            });
        },
        open(topic) {
            this.popup = true
            this.openTopic(topic)
        },
        searchTopic() {
            if (this.keyword != '') {
                this.search = true
                this.searchTopicKeyword(this.keyword)
            }
        },

    },
    computed: {
        show: {
            get() {
                return this.value
            },
            set(value) {
                this.$emit('input', value)
            }
        }
    },
}
</script>

<style>
.card-outter {
    position: relative;
    padding-bottom: 50px;
}
.card-actions {
    position: relative;

    bottom: 0;
}
</style>
