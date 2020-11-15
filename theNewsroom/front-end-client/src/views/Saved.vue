<template>
<div class="saved">
<template>

    <v-container fluid>
        <h2 class="subheading grey--text text-center" v-if="saved.length == 0">Looks like you haven't saved any Trends yet! You can save a selection of topics on the Trends page.</h2>
        <v-row v-else>
            <v-list two-line width=100% rounded>
                <v-list-item>
                    <HelpSaved />
                    <span> Need Help?</span>

                </v-list-item>
                <v-list-item  class="item" v-for="config in saved" :key="config.title" depressed hover @click.stop="viewTrends(config.topics)">

                    <v-col d-flex>
                        <v-list-item-title class="headline" v-text="config.title" />
                        <v-card-actions>
                            <v-row dense>
                                <!-- We would need ot make sure we limit the number of characters shown -->
                                <v-col v-for="topic in config.topics" :key="topic.id">
                                    <v-btn dark rounded width=100% depressed @click.stop="open(topic)" v-text='topic.name' />
                                </v-col>
                            </v-row>
                            <v-row class="edit" dense>
                                <v-spacer />
                                <v-col>
                                    <v-btn outlined text rounded width=100% depressed @click.stop="deleteTrend(config)">
                                        Delete
                                    </v-btn>
                                </v-col>
                            </v-row>
                        </v-card-actions>
                    </v-col>
                </v-list-item>
            </v-list>
        </v-row>
        <Popup v-model="popup" />
    </v-container>
</template>

{{configs}}
<v-divider />
{{saved}}

</div>
</template>

<script>
import Popup from "../components/common/Popup";
import HelpSaved from "../components/common/HelpSaved";
import USER_CONFIGS from "../graphql/AllOfAUsersConfigurations.gql"

import {
    mapGetters,
    mapState,
    mapMutations
} from 'vuex';

export default {
    name: "Topics",
    components: {
        Popup,
        HelpSaved
    },
    data: () => ({
        trend: {
            title: '',
            topics: []
        },
        dialog: false,
        popup: false,
        userId: '',
        configs: [],
        saved: [],
        skipQuery: false
    }),
    computed: {
        ...mapState(['saved']),
        ...mapGetters(['getSaved']),
    },
    apollo: {
        configs: {
            query: USER_CONFIGS,
            variables() {
                return {
                    userId: this.userId
                }
            },
            update(data) {
                data = data.allUserconfigurations.nodes.map(a => ({
                    title: a.configName,
                    topics: a.topicconfigurationsByUsrConfigId.nodes
                }))

    
                return data
            },
            skip() {
                return this.skipQuery
            },
        }
    },
    watch: {
        configs: {
            handler: function() {
                var i
                for (i = 0; i < this.configs.length; i++) {
                    var j
                    for (j = 0; i < this.configs[i].topics.length; j++) {
                        this.configs[i].topics[j] = {
                            id: this.configs[i].topics[j].topicByTopicId.id, name: this.configs[i].topics[j].topicByTopicId.name
                        }
                    }
                }
            }
        }
    },
    methods: {
        ...mapMutations([
            'openTopic',
            'setSelected',
            'deleteTrend',
        ]),
        open(title) {
            this.popup = true
            this.openTopic(title)
        },
        viewTrends(selection) {
            this.setSelected(selection)
            this.$router.push({
                name: 'trends'
            })
        },
        async getConfigs() {
            this.$apollo.queries.configs.skip = false
            await this.$apollo.queries.configs.refetch()
            this.saved = this.configs
        }
    },
    mounted: function() {
        // this.userId = this.$auth.user.sub
        this.userId = "hello"
        console.log(this.userId)
        this.getConfigs()
        // this.saved = this.configs
    //     // this.$apollo.queries.saved.refetch()
    }

}
</script>

<style scoped>
td {
    text-align: center !important;
}
.saved {
    padding-top: 20px
}
.edit {
    max-width: 150px;
}
.item {
    background: rgb(230, 235, 255);
}
.item:hover {
    background:rgb(222, 229, 255);
}
</style>