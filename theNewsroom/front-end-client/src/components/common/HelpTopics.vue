<template>
  <v-row class="flex-wrap text-justify justify-space-between">
    <v-btn
        icon
      @click="overlay = !overlay"
      class="ml-1 mt-3"
    >
      <v-icon>mdi-help-circle-outline</v-icon> <!--<mdiHelpCircle/>-->
    </v-btn>

    <v-overlay
      :opacity="0.3"
      :value="overlay"
    >
        <v-card light class="flex-wrap text-justify justify-space-between" v-model="menu" :close-on-content-click="false">
            <v-card-title>Need Help?</v-card-title>
            <v-card-text>{{ helpMessage }}</v-card-text>
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn depressed @click="overlay = false">
                    Close
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-overlay>
  </v-row>
</template>


<script>

    export default {
        data: () => ({
        overlay: false,
        zIndex: 5,
        helpMessage: 'Description of how to use the topics page specfically'
        }),
        components: {
        }
    }
</script>
