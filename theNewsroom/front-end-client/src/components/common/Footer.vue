<template>
<v-container>
    <v-footer padless>
        <v-card flat class="text-center">
            <v-divider></v-divider>

            <v-card-text class="pt-0">Here at the Newsroom, we want to show you more than just the news. We want to look beyond, to see the shifts and patterns in how the news is told, and how the world is kept informed. </v-card-text>

            <v-card-text class="pt-0">The team here are:</v-card-text>
            <v-card-text class="pt-0 grey--text">
                <strong>Liam Dale</strong> |
                <strong>James Tatham</strong> |
                <strong>Lance Young</strong> |
                <strong>Jonothan Chan</strong> |
                <strong>Ronan O'Hara</strong>
            </v-card-text>
            <v-divider></v-divider>
            <div>For a list of attributions and credits, see <a href="http://localhost:8080/credits">here.</a></div>
            <v-divider></v-divider>

            <v-card-text>
                {{ new Date().getFullYear() }} —
                <strong>The Newsroom</strong>
            </v-card-text>
        </v-card>
    </v-footer>
</v-container>
</template>

<script>
export default {
    name: "Header",
    data: () => ({})
};
</script>
