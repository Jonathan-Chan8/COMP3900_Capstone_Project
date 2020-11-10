<template>
<div class="home">
    <h1 class="body subheading grey--text text-center">Welcome to the Newsroom</h1>
    <v-container fluid>

        <v-row>
            <!-- Topic of the Day -->
            <v-col   cols="12" md='6'>
                <v-card class="flex-wrap text-justify justify-space-between" height="100%" width="100%" hover @click="open(topics[0])">
                    
                    <v-card-title class="headline">Topic of the Day</v-card-title>
                    <v-spacer/>


                    <v-card-text class="text-center font-weight-bold" v-resize-text v-text='topics[1].name' />
                    <v-card-text class='text-center'> {{topics[1].topicofarticlesByTopicId.totalCount}} articles</v-card-text>

                    

                </v-card>
                <Popup v-model="popup" />
            </v-col>

                        <!-- Login/Register/Saved -->

            <v-col   cols="12" md='6'>
                <!-- Show login/register when user is not authenticated -->
                <v-card v-if="!$auth.loading && !$auth.isAuthenticated" class="flex-wrap text-justify justify-space-between" height="100%" width="100%" hover>
                    <v-card-title class="headline" v-text="unauth.title" />
                    <v-card-text v-text='unauth.text' />
                    <v-card-actions>
                        <v-btn depressed width=100% large @click="login">
                            Log In / Register
                        </v-btn>
                    </v-card-actions>
                </v-card>

                <!-- show saved/logout when user is authenticated -->
                <v-card v-else class="flex-wrap text-justify justify-space-between" height="100%" hover :to='saved.route'>
                    <v-card-title class="headline" v-text="saved.title" />
                    <v-card-text v-text='saved.text' />
                </v-card>
            </v-col>

            

            <!-- Topics/Trends -->
            <v-col v-for="card in cards" :key="card.id"   cols="12"
 md='6'>
                <v-card class="flex-wrap text-justify justify-space-between" rounded height="100%" width="100%" hover :to='card.route'>
                    <v-card-title class="headline" v-text="card.title" />
                    <v-card-text v-text='card.text' />
                </v-card>
            </v-col>
        </v-row>
    </v-container>

</div>
</template>

<script>
import Popup from "../components/common/Popup";

import ALL_TOPICS_WITH_FILTER from '../graphql/TopicsAndArticleCount.gql'

import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

export default {
    name: "Home",
    components: {
        Popup
    },

    data() {
        return {
            popup: false,
            auth: true,

            absolute: true,
            opacity: 10,
            overlay: false,
            unauth: {
                id: 'unreg',
                title: 'Register or Log In',
                text: ' Log in or register an account to get access to additional features, such as selecting more topics on your Trends graph and saving topics for later!',
                route: '/register'
            },
            saved: {

                id: 'saved',
                title: 'My Saved Trends',
                text: 'Click here to view your saved trends, and explore how your selected topics are behaving!',
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
                    text: 'Sometimes, you just need to see the big picture. On the Topics page, you can explore the most popular news topics however you want. Adjust the time period, and filter by media outlets, to view which topics are the most prominent in the media landscape. Click to go to Topics!',
                    route: '/topics'
                },
                {
                    id: 'trends',
                    title: 'What is Trends?',
                    text: 'Looking to see how news topics change in relation to each other? Head to the Trends page to view the popularity of selected topics over time on a line graph. You can register an account for additional features, such as saving Trends configurations for later and selecting additional topics. Click to go to Trends!',
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
            'addSelected',
            'removeSelected',
            'openTopic',
            'nextTopic',
            'previousTopic',
            'closeTopic'
        ]),
        login() {
            this.$auth.loginWithPopup();
        },
        // Log the user out
        logout() {
            this.$auth.logout({
                returnTo: window.location.origin
            });
        },
        open(topic) {
            this.popup = true
            this.openTopic(topic)
        }

    },
    computed: {
        ...mapState(['popup', 'popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected']),

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

<!-- Defining a v-cards class as card-outter will provide enough spacing for buttons beneath. Not necessary if the entire v-card is a route, but important if we want to include buttons as well -->

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
