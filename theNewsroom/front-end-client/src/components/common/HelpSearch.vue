<template>
<div>
    <v-dialog d-flex elevation="0" v-model="show" width="500">
        <template v-slot:activator="{ on, attrs }">
            <v-btn icon v-bind="attrs" v-on="on">
                <v-icon>mdi-help-circle-outline</v-icon>
            </v-btn>
        </template>

        <v-card>
            <v-card-title class="headline">
                Need Help?
            </v-card-title>

            <v-card-text class="flex-wrap text-justify justify-space-between">
                <p>You can click on one of the <b>Topics</b> to bring up its popup so you can see its information, and add to your trends if you wish.</p>
                <p><b>Close</b> will close this popup. Clicking anywhere other than this popup will also close it.</p>

            </v-card-text>
            {{getArticle}}
            <v-card-actions>
                <v-row dense>

                    <v-col>

                        <v-btn width=100% rounded depressed @click.stop="close">
                            Close
                        </v-btn>

                    </v-col>

                </v-row>

            </v-card-actions>
        </v-card>
    </v-dialog>
</div>
</template>

<script>
import {
    mapState,
    mapGetters,
} from 'vuex';

export default {
    data: () => ({
        show: false
    }),

    props: {
        value: Boolean
    },

    compute: {
        ...mapState(['current_article']),
        ...mapGetters(['getArticle']),

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
        close() {
            this.show = false
        }
    },
}
</script>
