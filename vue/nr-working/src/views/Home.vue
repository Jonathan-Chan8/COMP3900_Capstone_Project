<template>
<div class="home">
    <h1 class="subheading grey--text text-center">Welcome to the Newsroom</h1>

    <v-container fluid>
        <v-row justify=“center” align=“center”>
            <v-col v-for="card in cards" :key="card.id" cols='auto' sm='6'>
                <v-card class="card-outter flex-wrap text-justify justify-space-between" rounded height="100%" hover>
                    <v-card-title class="headline" v-text="card.title"></v-card-title>

                    <v-card-text> {{ card.text }} </v-card-text>

                    <v-card-actions v-if="card.id === 'unreg'" class="card-actions">
                        <v-btn depressed small>
                            Register
                        </v-btn>

                        <v-btn depressed small>
                            Log In
                        </v-btn>
                    </v-card-actions>
                    <v-card-actions v-else class="card-actions">
                        <v-btn depressed small>
                            View {{ card.title }}
                        </v-btn>
                    </v-card-actions>

                </v-card>
            </v-col>
        </v-row>
    </v-container>

</div>
</template>

<script>
export default {
    data() {
        return {
            cards: [{
                    id: 'topics',
                    title: 'Topics',
                    text: 'Sometimes, you just need to see the big picture. On the Topics page, you can explore the most popular news topics however you want. Adjust the time period, and filter by media outlets, to view which topics are the most prominent in the media landscape.',
                    route: '/topics'
                },
                {
                    id: 'totd',
                    title: "Today's Topic",
                    text: 'We will have here some function to request the most popular topic in the last 24 hours, and clicking it will open the associated overlay. Or, we could simply have this as that topics popup info. Lots of options!',
                    route: '/'
                },
                {
                    id: 'trends',
                    title: 'Trends',
                    text: 'Looking to see how news topics change in relation to each other? Head to the Trends page to view the popularity of selected topics over time on a line graph. You can register an account for additional features, such as saving Trends configurations for later and selecting additional topics.',
                    route: '/trends'
                },
                {
                    id: 'unreg',
                    title: 'Register',
                    text: 'Looking to see how news topics change in relation to each other? Head to the Trends page to view the popularity of selected topics over time on a line graph. You can register an account for additional features, such as saving Trends configurations for later and selecting additional topics.',
                    route: '/register'
                },
                {
                    id: 'saved',
                    title: 'Saved Trends',
                    text: 'Click here to view your saved trends, and explore how your selected topics are behaving!',
                    route: '/trends'
                }
            ]

        }
    }
}
</script>

<style>
.card-outter {
    position: relative;
    padding-bottom: 50px;
}

.card-actions {
    position: absolute;
    bottom: 0;
}
</style>
