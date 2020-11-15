<template>
<div class="saved">
<template>

    <v-container fluid>
        <h2 class="subheading grey--text text-center" v-if="getSaved.length == 0">Looks like you haven't saved any Trends yet! You can save a selection of topics on the Trends page.</h2>
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
        saved: []
    }),
    computed: {
        ...mapState(['saved']),
        ...mapGetters(['getSaved']),
    },
    apollo: {
        saved: {
            query: USER_CONFIGS,
            variables() {
                return {
                    userId: this.userId
                }
            },
            update(data) {
                return {
                    data: data.allUserconfigurations.nodes
                }
            },
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
        }
    },
    mounted: function() {
        this.userId = this.$auth.user.sub
        console.log(this.userId)
        // this.$apollo.queries.saved.refetch()
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
