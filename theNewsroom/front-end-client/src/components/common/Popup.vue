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
                <!-- We would need ot make sure we limit the number of characters shown -->
                <v-col v-for="topic in topics" :key="topic" md=6>
                    <v-btn width=100% depressed @click.stop="nextTopic(topic)" v-text='topic' />
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
                <v-col v-for="article in articles" :key="article" md=6>
                    <v-btn small width=100% depressed v-text='article' />
                </v-col>
            </v-row>
        </v-card-actions>

        <v-divider />
        <v-card-actions>
            <v-row dense>
                <v-col>
                    <v-btn width=100% v-if='isSelected' rounded depressed @click='removeSelected(current_topic)'>
                        Remove from Trend
                    </v-btn>

                    <v-btn width=100% v-else rounded depressed @click='addSelected(current_topic)'>
                        Add to Trend
                    </v-btn>
                </v-col>

                <v-col>

                    <v-btn width=100% v-if='!isRoot' rounded depressed @click="previousTopic">
                        Previous
                    </v-btn>
                </v-col>

                <v-col>

                    <v-btn width=100% rounded depressed @click.stop="close">
                        Close
                    </v-btn>

                </v-col>

            </v-row>

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
        topics: ['Coronavirus', 'U.S. Election', 'Californian Bushfires', 'New Zealand', 'Melbourne', 'Scott Morrison',

        ],

        articles: ['Victoria records 2 new cases', 'Oxford Vaccine passes clinical trial', 'Joe Biden leading polls', 'Victoria records 2 new cases', 'Oxford Vaccine passes clinical trial', 'Joe Biden leading polls'

        ]

    }),

}
</script>
