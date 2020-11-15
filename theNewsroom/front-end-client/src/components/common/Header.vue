<template>
<v-toolbar class="toolbar" fixed flat max-height="65" dark>
    <v-btn text>
        <v-toolbar-title class="text-uppercase">
            <router-link to="/">
                <span class="font-weight-light white--text">The</span>
                <span class="white--text">Newsroom</span>
            </router-link>
        </v-toolbar-title>
    </v-btn>
    <v-spacer />

    <!-- Full screen size -->
    <v-toolbar-items class="d-none d-md-block">
        <v-btn text depressed to='/topics'>Topics</v-btn>
        <v-btn text depressed to='/trends'>Trends</v-btn>
        <v-btn text depressed v-if="!$auth.loading && !$auth.isAuthenticated" @click="login">Log In / Register</v-btn>
        <v-btn v-if="!$auth.loading && $auth.isAuthenticated" depressed to='/saved'>Saved</v-btn>
        <v-btn v-if="!$auth.loading && $auth.isAuthenticated" text depressed @click="logout">Log Out</v-btn>

    </v-toolbar-items>

    <!-- Small screen size -->
    <div class="d-md-none">
        <v-menu>
            <template v-slot:activator="{ on }">
                <v-app-bar-nav-icon v-on="on" />
            </template>
            <v-list class="responsiveMenu" size="auto">
                <v-list-item text v-for="item in menu" :key="item.icon" :to="item.route" depressed v-text='item.title' />
                <template v-if="!$auth.loading && !$auth.isAuthenticated">
                    <v-list-item text @click="login">
                        Log In
                    </v-list-item>
                    <v-list-item text @click="login">
                        Register
                    </v-list-item>
                </template>
                <template v-else>
                    <v-list-item text to='/saved'>
                        Saved
                    </v-list-item>
                    <v-list-item text @click="logout">
                        Log Out
                    </v-list-item>
                </template>
            </v-list>
        </v-menu>
    </div>

</v-toolbar>
</template>

<script>
export default {
    name: "Header",
    methods: {
        login() {
            this.$auth.loginWithPopup();
        },
        logout() {
            this.$auth.logout({
                returnTo: window.location.origin
            });
        }
    },
    data: () => ({
        auth: true,
        drawer: false,
        saved: {
            icon: 'saved',
            title: 'Saved Trends',
            route: '/saved'
        },
        menu: [{
                icon: 'topics',
                title: 'Topics',
                route: '/topics'
            },
            {
                icon: 'trends',
                title: 'Trends',
                route: '/trends'
            },
        ]
    }),
}
</script>

<style scoped>
.v-toolbar.v-toolbar--absolute {
    width: auto;
    height: auto;
}
</style>
