<template>
<v-dialog d-flex elevation="0" v-model="show" max-width="600px" max-height="100px">
    <v-card class="flex-wrap text-justify justify-space-between">
        <v-card-title class="headline">
            Edit Trend
        </v-card-title>
        <v-card-text>
            <v-text-field v-model='name' :rules="[
                () => !!name || 'This field is required',
                () => !!name && this.selected.length > 0 || 'Please select a topic first', 
                () => !!name && name.length > 3 || 'Name must have more than 3 characters',
                () => !!name && name.length <= 25 || 'Name must be less than 20 characters', 
                ]" placeholder="Enter a name for your selection" counter="20" />
        </v-card-text>
        <v-card-actions>
            <v-spacer />
            <v-btn depressed rounded @click.stop="close">
                Close
            </v-btn>
            <v-btn depressed rounded @click="saveTrendSelection(name)">
                Save
            </v-btn>
        </v-card-actions>
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
        ...mapState(['saved', 'popups', 'selected', 'current_topic']),
        ...mapGetters(['isRoot', 'numSelected', 'isSelected', 'getSelected', 'getSaved', 'getRelated']),

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
            'emptySelected',
            'setSelected',
            'saveTrend'
        ]),
        close() {
            this.show = false
        },
        saveTrendSelection(name) {
            if (this.name.length > 3 && this.name.length <= 20 && this.selected.length > 0) {
                this.dialog = false
                this.saveTrend(name)
            }
            this.close()

        }
    },

    data: () => ({
        name: '',

    }),

}
</script>
