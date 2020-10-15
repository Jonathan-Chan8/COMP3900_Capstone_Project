<template>
<v-container>
    <v-toolbar flat class="mainHeader">
        <v-btn text>
            <v-toolbar-title class="text-uppercase">
                <router-link to="/">
                    <span class="font-weight-light black--text">The</span>
                    <span class="black--text">Newsroom</span>
                </router-link>
            </v-toolbar-title>
        </v-btn>
        <v-spacer></v-spacer>
        <!-- Need to properly implement the login authorisation methods once that story is completed -->
        <v-toolbar-items class="d-none d-md-block">
            <v-btn text v-for="item in menu" :key="item.icon" :to="item.route" depressed>{{ item.title }}
            </v-btn>

            <template v-if="!$auth.loading">
                <!-- show login/register when not authenticated -->
                <v-btn text depressed v-if="!$auth.isAuthenticated" @click="login">Log In</v-btn>
                <v-btn text depressed v-if="!$auth.isAuthenticated" @click="login">Register</v-btn>

                <!-- show saved/logout when authenticated -->
                <v-menu v-if="$auth.isAuthenticated" offset-y>
                    <template v-slot:activator=" { on }">
                        <v-btn text v-on="on">
                            <span>My Account</span>
                        </v-btn>
                    </template>
                    <v-list class="responsiveMenu">
                        <!-- show saved/logout when authenticated -->
                        <v-list-item text v-if="$auth.isAuthenticated" to='/profile'>Profile</v-list-item>
                        <v-list-item text v-if="$auth.isAuthenticated" to='/saved'>Saved Trends</v-list-item>
                        <v-list-item text v-if="$auth.isAuthenticated" @click="logout">Log Out</v-list-item>
                    </v-list>
                </v-menu>
            </template>
        </v-toolbar-items>

        <div class="d-md-none">
            <v-menu>
                <template v-slot:activator="{ on }">
                    <v-app-bar-nav-icon v-on="on"></v-app-bar-nav-icon>
                </template>
                <v-list class="responsiveMenu" size="auto">
                    <!-- Always shown -->

                    <v-list-item text v-for="item in menu" :key="item.icon" :to="item.route" depressed>{{ item.title }}
                    </v-list-item>

                    <template v-if="!$auth.loading">
                        <!-- show login/register when not authenticated -->
                        <v-list-item text v-if="!$auth.isAuthenticated" @click="login">Log In</v-list-item>
                        <v-list-item text v-if="!$auth.isAuthenticated" @click="login">Register</v-list-item>

                        <!-- show saved/logout when authenticated -->
                        <v-list-item text v-if="$auth.isAuthenticated" to='/profile'>Profile</v-list-item>
                        <v-list-item text v-if="$auth.isAuthenticated" to='/saved'>Saved Trends</v-list-item>
                        <v-list-item text v-if="$auth.isAuthenticated" @click="logout">Log Out</v-list-item>
                    </template>

                </v-list>
            </v-menu>
        </div>

    </v-toolbar>
</v-container>
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
            }
        ]

    }),
}
</script>
