<template>
<v-dialog d-flex elevation="0" v-model="show" width="1000px" height="500px">
    <v-card class=" flex-wrap text-justify justify-space-between">
        <v-card-title class="headline font-weight-bold" v-text='current_topic.name' />
        <v-divider />
        <v-card-title class="subheading">
            Related Topics
        </v-card-title>
        <v-card-actions>
            <v-row dense>
                <!-- We would need ot make sure we limit the number of characters shown -->
                <v-col v-for="topic in topics" :key="topic.id" md=6>
                    <v-btn color="rgb(230, 235, 255)" rounded width=100% depressed @click.stop="nextTopic(topic)" v-text='topic.name' />
                </v-col>
            </v-row>
        </v-card-actions>
        <v-divider />
        <v-card-title class="subheading">
            Top Articles
        </v-card-title>
        <!-- We need to make sure we limit the number of characters shown -->
        <v-list depressed rounded >
                <v-list-item class="item align-items=center" v-for="article in articles" :key="article" depressed @click='open(article)'>
                    <v-list-item-title v-text='article.articleByArticleId.title.slice(0, 100)' />
                </v-list-item>

        </v-list>
        <v-divider />
        <v-card-actions>
            <v-row dense>
                <v-btn  v-if='isSelected' rounded depressed @click='removeSelected(current_topic)'>
                    Remove
                </v-btn>
                <v-btn  v-else rounded depressed @click='addSelected(current_topic)'>
                    Add
                </v-btn>
                <v-spacer />
                <v-btn  v-if='!isRoot' rounded depressed @click="previousTopic">
                    Previous
                </v-btn>
                <v-btn  rounded depressed @click.stop="close">
                    Close
                </v-btn>
                <HelpPopup />
            </v-row>
        </v-card-actions>
    </v-card>
    <Article v-model="article" />

</v-dialog>
</template>

<script>
import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

import HelpPopup from "./HelpPopup";
import Article from "./Article";

import ALL_TOPICS_WITH_FILTER from '../../graphql/TopicsAndArticleCount.gql'
import TOP_ARTICLES_FROM_TOPIC from '../../graphql/TopArticlesFromTopic.gql'

export default {
    props: {
        value: Boolean
    },

    components: {
        HelpPopup,
        Article
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
            'closeTopic',
            'openArticle'
        ]),
        close() {
            this.show = false
            this.closeTopic()
        },
        open(article) {
            this.article = true
            this.openArticle(article)
        }
    },

    data: () => ({
        article: false,
        topics: [],
        articles: [],
    }),

    apollo: {
        topics: {
            query: ALL_TOPICS_WITH_FILTER,
            variables() {
                return {
                    limit: 6
                }
            },
            update(data) {
                return data.allTopics.nodes;
            }
        },
        articles: {
            query: TOP_ARTICLES_FROM_TOPIC,
            variables() {
                var id
                if (this.current_topic == '') {
                    id = 1
                } else {
                    id = this.current_topic.id
                }
                return {
                    topicId: id
                }
            },
            update(data) {
                return data.topicById.topicofarticlesByTopicId.nodes;
            }
        }

    },

}
</script>

<style scoped>
.v-list-item {
    justify-content: center !important;
    flex-direction: row !important;
    text-align: center !important;
    align-items: center !important;
}

.item {
    background: rgb(230, 235, 255);

}

.item:hover {
     background:rgb(222, 229, 255);

}


</style>
