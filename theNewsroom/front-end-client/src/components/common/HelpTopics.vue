<template>
  <div class="text-center">
    <v-dialog
      v-model="dialog"
      width="500"
    >
      <template v-slot:activator="{ on, attrs }">
        <v-btn
          icon
          v-bind="attrs"
          v-on="on"
          class="mt-3"
        >
           <v-icon>mdi-help-circle-outline</v-icon>
        </v-btn>
      </template>

      <v-card>
        <v-card-title class="headline">
            Need Help?
        </v-card-title>


        <v-card-text>
            <p><b>The Nav Bar</b> at the top of the page can be used to access the home page, trends page and account functionality.</p>
            <p><b>The Search Bar</b> on the left of the page can be used to look up a specific topic so that you can view its information.</p>
            <p><b>The Time Period</b> drop down on the left of the page can be used to filter by dates which articles you would like to be included in your topics.</p>
            <p><b>The Media Outlet</b> search bar on the left of the page can be used to filter by articles included in your topic analysis by the publishing media outlet.</p>
            <p><b>The Topics Table</b> displays the topics as filtered by your search, time period and media outlet parameters; or by default the most popular articles. 
                  You can use the sort buttons at the top of each column to change the order of the rows according to number of articles and topic title.
                  You can also set the number of rows you want displayed at once, using the filter below the table, and view the next or previous set of
                  rows with the arrows at the bottom.</p>

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