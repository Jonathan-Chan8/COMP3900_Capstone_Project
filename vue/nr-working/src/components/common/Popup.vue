<template>
<v-dialog d-flex v-model="show" max-width="1000px" max-height="500px">
    <v-card class="flex-wrap text-justify justify-space-between">
        <v-card-title class="headline"> Coronavirus </v-card-title>
        <v-divider />

        <v-card-title class="subheading"> Related Topics </v-card-title>
        <v-card-actions>
            <v-row dense>
                <!-- we would need ot make sure we limit the number of characters shown -->
                <v-col v-for="topic in topics" :key="topic.id">
                    <v-btn width=100% depressed>{{ topic.title }}</v-btn>
                </v-col>
            </v-row>
        </v-card-actions>

        <v-divider />

        <v-card-title class="subheading"> Top Articles </v-card-title>
        <v-card-actions>
            <v-row dense>
                <!-- we would need ot make sure we limit the number of characters shown -->
                <v-col v-for="article in articles" :key="article.id" md=6>
                    <v-btn small width=100% depressed>{{ article.title }}</v-btn>
                </v-col>
            </v-row>
        </v-card-actions>

        <v-divider />
        <v-card-actions>
            <v-btn depressed>Remove from Trends</v-btn>
            <v-btn depressed>Add to Trends</v-btn>

            <v-spacer></v-spacer>
            <v-btn depressed>Back</v-btn>
            <v-btn depressed @click.stop="show=false">Close</v-btn>
        </v-card-actions>

    </v-card>
</v-dialog>
</template>

// 

<script>
// import {
//     mapGetters,
//     mapState,
//     mapMutations
// } from 'vuex';

export default {
    props: {
        value: Boolean
    },
    // methods: {
    //     ...mapMutations([
    //         'addSelected',
    //         'removeSelected',
    //         'openTopic',
    //         'nextTopic',
    //         'previousTopic',
    //         'closeTopic'
    //     ])
    // },
    // computed: {
    //     ...mapState(['popups', 'selected', 'current_topic']),
    //     ...mapGetters(['isRoot', 'numSelected', 'isSelected'])
    // },
    data: () => ({
        topics: [{
                id: '1',
                title: 'covid'

            },
            {
                id: '2',
                title: 'election'
            },
            {
                id: '3',
                title: 'melbourne'
            }, {
                id: '4',
                title: 'covid'

            },
            {
                id: '5',
                title: 'election'
            },
            {
                id: '6',
                title: 'melbourne'
            }
        ],

        articles: [{
                id: '1',
                title: 'Victoria records 2 new cases'

            },
            {
                id: '2',
                title: 'Oxford Vaccine passes clinical trial'
            },
            {
                id: '3',
                title: 'Joe Biden leading polls'
            },
            {
                id: '1',
                title: 'Victoria records 2 new cases'

            },
            {
                id: '2',
                title: 'Oxford Vaccine passes clinical trial'
            },
            {
                id: '3',
                title: 'Joe Biden leading polls'
            }
        ]

    }),

}
</script>
