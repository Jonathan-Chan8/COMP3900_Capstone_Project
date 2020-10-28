<template>
<div class="text-center">
    <v-dialog v-model="dialog" width="500">
        <template v-slot:activator="{ on, attrs }">
            <v-btn icon v-bind="attrs" v-on="on" class="mt-3">
                <v-icon>mdi-help-circle-outline</v-icon>
            </v-btn>
        </template>

        <v-card>
            <v-card-title class="headline">
                Need Help?
            </v-card-title>

            <v-card-text class="flex-wrap text-justify justify-space-between">
                <p><b>The Nav Bar</b> at the top of the page can be used to access the home page, topics page and account functionality.</p>
                <p><b>The Filters</b> drop down can be used to search for specific topics to add to your Selected Topics, while the time period dropdown can be used to set the parameter of what period you want to view the trends over.</p>
                <p><b>Selected Topics</b> provides a list of the topics being displayed on the graph, you can remove topics from the list via its corresponding remove button.</p>
                <p><b>Related Topics</b> provides a range of suggested topics you may like to add to your Selected Topics, the suggestions are based on their association to your currently selected topics.</p>
            </v-card-text>

            <!--
        <v-divider></v-divider>

        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn depressed @click="dialog = false">Close</v-btn>
        </v-card-actions>
        -->
        </v-card>
    </v-dialog>
</div>
</template>

<script>
export default {
    data: () => ({}),

    methods: {
        close() {
            this.show = false
        }
    },
}
</script>
