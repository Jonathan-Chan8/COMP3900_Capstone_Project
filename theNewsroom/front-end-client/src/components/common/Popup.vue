<template>
<v-dialog d-flex elevation="0" v-model="show" max-width="1000px" max-height="500px">

    <v-card class="flex-wrap text-justify justify-space-between">
        <v-card-title class="headline" v-text='current_topic' />
        <v-divider />

        <v-card-title class="subheading">
            Related Topics
        </v-card-title>
        <v-card-actions>
            <v-row dense>
                <!-- We need to make sure we limit the number of characters shown -->
                <v-col v-for="topic in topics" :key="topic.id">
                    <v-btn width=100% depressed @click="nextTopic(topic.title)" v-text='topic.title' />'
                </v-col>
            </v-row>
        </v-card-actions>
        <v-divider />
        <v-card-title class="subheading">
            Top Articles
        </v-card-title>
        <v-card-actions>
            <v-row dense>
                <!-- We need to make sure we limit the number of characters shown -->
                <v-col v-for="article in articles" :key="article.id" md=6>
                    <v-btn small width=100% depressed v-text='article.title' />
                </v-col>
            </v-row>
        </v-card-actions>

        <v-divider />
        <v-card-actions>
            <v-btn v-if='isSelected' depressed @click='removeSelected(current_topic)'>
                Remove from Trends
            </v-btn>
            <v-btn v-else depressed @click='addSelected(current_topic)'>
                Add to Trends
            </v-btn>
            <v-spacer />
            <v-btn v-if='!isRoot' depressed @click="previousTopic">
                Previous Topic
            </v-btn>
            <v-btn depressed @click.stop="close">
                Close
            </v-btn>
        </v-card-actions>

        <v-text> Current Topic: {{ current_topic}} </v-text>
        <v-spacer />
        <v-text> Popup Stack: {{ getPopups}} </v-text>
        <v-spacer />
        <v-text> Selected Topics: {{ getSelected}} </v-text>

    </v-card>
</v-dialog>
</template>

<script>
import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

export default {
    props: {
        value: Boolean
    },

    computed: {
        ...mapState(['popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getPopups']),

        show: {
            get() {
                return this.value
            },
            set(value) {
                this.$emit('input', value)
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
        close() {
            this.show = false
            this.closeTopic()
        }
    },

    data: () => ({
        topics: [{
                id: '1',
                title: 'Coronavirus',
            },
            {
                id: '2',
                title: 'U.S. Election',
            },
            {
                id: '3',
                title: 'Californian Bushfires',
            },
            {
                id: '4',
                title: 'New Zealand',
            },
            {
                id: '5',
                title: 'Melbourne',
            }, {
                id: '6',
                title: 'Scott Morrison',
            },
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
