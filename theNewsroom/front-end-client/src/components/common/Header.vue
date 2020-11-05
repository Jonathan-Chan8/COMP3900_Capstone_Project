<template>
<v-toolbar fixed flat max-height="65" class="toolbar" dark>
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
        <v-btn text v-for="item in menu" :key="item.icon" :to="item.route" depressed>{{ item.title }}
        </v-btn>

        <v-btn text depressed v-if="!$auth.loading && !$auth.isAuthenticated" @click="login">Log In / Register</v-btn>

        <!-- show saved/logout when authenticated -->
        <v-menu v-else offset-y>
            <template v-slot:activator=" { on }">
                <v-btn text v-on="on">
                    My Account
                </v-btn>
            </template>
            <v-list class="responsiveMenu">
                <!-- show saved/logout when authenticated -->
                <v-list-item text v-if="$auth.isAuthenticated" to='/profile'>
                    Profile
                </v-list-item>
                <v-list-item text v-if="$auth.isAuthenticated" to='/saved'>
                    Saved Trends
                </v-list-item>
                <v-list-item text v-if="$auth.isAuthenticated" @click="logout">
                    Log Out
                </v-list-item>
            </v-list>
        </v-menu>

    </v-toolbar-items>

    <!-- Small screen size -->
    <div class="d-md-none">
        <v-menu>
            <template v-slot:activator="{ on }">
                <v-app-bar-nav-icon v-on="on" />
            </template>
            <v-list class="responsiveMenu" size="auto">
                <!-- Always shown -->
                <v-list-item text v-for="item in menu" :key="item.icon" :to="item.route" depressed v-text='item.title' />

                <!-- show login/register when not authenticated -->
                <template v-if="!$auth.loading && !$auth.isAuthenticated">
                    <v-list-item text @click="login">
                        Log In
                    </v-list-item>
                    <v-list-item text @click="login">
                        Register
                    </v-list-item>
                </template>

                <!-- show saved/logout when authenticated -->
                <template v-else>
                    <v-list-item text to='/profile'>
                        Profile
                    </v-list-item>
                    <v-list-item text to='/saved'>
                        Saved Trends
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
        // Log the user in
        login() {
            this.$auth.loginWithPopup();
        },
        // Log the user out
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
