<template>
<div class="home">
    <h1 class="body subheading grey--text text-center">Welcome to the Newsroom</h1>
    <v-container fluid>
        <v-row>
            <!-- Login/Register/Saved -->
            <template v-if="!$auth.loading">
                <v-col cols='auto' md='6'>
                    <!-- show login/register when user is not authenticated -->
                    <v-card v-if="!$auth.isAuthenticated" class="flex-wrap text-justify justify-space-between" rounded height="100%" hover>
                        <v-card-title class="headline" v-text="unauth.title"></v-card-title>
                        <v-card-text> {{ unauth.text }} </v-card-text>
                        <v-card-actions>
                            <v-btn depressed width=100% large @click="login">Log In / Register</v-btn>
                        </v-card-actions>

                    </v-card>

                    <!-- show saved/logout when user is authenticated -->
                    <v-card v-else class="flex-wrap text-justify justify-space-between" rounded height="100%" hover>
                        <v-card-title class="headline" v-text="saved.title"></v-card-title>
                        <v-card-text> {{ saved.text }} </v-card-text>
                    </v-card>

                </v-col>
            </template>

            <!-- Topic of the Day -->
            <v-col cols='auto' md='6'>
                <!-- <v-card class="flex-wrap text-justify justify-space-between" rounded height="100%" hover @click="open()"> -->
                <v-card class="flex-wrap text-justify justify-space-between" rounded height="100%" hover @click="open(totd.topic)">

                    <v-card-title class="headline" v-text="totd.title"></v-card-title>
                    <v-card-text> {{ totd.text }} </v-card-text>
                </v-card>
                <Popup v-model="popup" />

            </v-col>

            <!-- Topics/Trends -->
            <v-col v-for="card in cards" :key="card.id" cols='auto' md='6'>
                <v-card class="flex-wrap text-justify justify-space-between" rounded height="100%" hover :to='card.route'>
                    <v-card-title class="headline" v-text="card.title"></v-card-title>
                    <v-card-text> {{ card.text }} </v-card-text>
                </v-card>
            </v-col>

        </v-row>
    </v-container>

</div>
</template>

<!-- Need to figure out a way to only show the correct cards for if a user is signed in or not -->

<script>
import Popup from "../components/common/Popup";

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
            ]

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
        // ...mapMutations([
        //     'openTopic',
        // ]),
        open(topic) {
            this.popup = true
            this.openTopic(topic)
        }
        // No idea why the above wont work!
        // open(topic) {
        //     this.popup = true
        //     this.$store.state.current_topic = topic
        // }
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
