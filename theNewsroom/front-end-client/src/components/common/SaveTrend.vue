<template>
<v-dialog v-model="save" max-width="600px" max-height="100px">
    <template v-slot:activator="{ on, attrs }">
        <v-btn depressed rounded v-bind="attrs" v-on="on">
            Save
        </v-btn>
    </template>

    <v-card class="flex-wrap text-justify justify-space-between">
        <v-card-title>
            <span class="headline">Save Trend Selection</span>
        </v-card-title>
        <v-card-text>
            <v-text-field v-model='title' :rules="[
                () => !!title || 'This field is required',
                () => !!title && this.getSelected.length > 0 || 'Please select a topic first', 
                () => !!title && title.length > 3 || 'Name must have more than 3 characters',
                () => !!title && title.length <= 25 || 'Name must be less than 20 characters', 
                ]" placeholder="Enter a name for your selection" counter="20" />
        </v-card-text>
        <v-card-actions>
            <v-spacer />
            <v-btn depressed rounded @click.stop="close">
                Close
            </v-btn>
            <v-btn depressed rounded @click="saveTrendSelection(title)">
                Save
            </v-btn>
        </v-card-actions>
    </v-card>
</v-dialog>
</template>

<script>
import {
    mapGetters,
    mapMutations
} from 'vuex';
export default {
    props: {
        value: Boolean
    },
    data: () => ({
        title: null,
        save: false
    }),
    computed: {
        ...mapGetters(['getSelected']),
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
            'saveTrend'
        ]),
        close() {
            this.save = false
        },
        saveTrendSelection(title) {
            if (this.title.length > 3 && this.title.length <= 20 && this.getSelected.length > 0) {
                this.saveTrend(title.charAt(0).toUpperCase() + title.slice(1))
                this.close()
            }
        }
    },
    
}
</script>
