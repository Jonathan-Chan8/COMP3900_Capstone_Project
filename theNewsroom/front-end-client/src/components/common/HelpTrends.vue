<template>
  <div class="text-left">
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