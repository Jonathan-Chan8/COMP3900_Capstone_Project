<template>
<nav>
    <v-toolbar flat app>

        <v-btn flat depressed text-color="grey" to='/'>
            <v-toolbar-title class="text-uppercase grey--text">
                <span class="font-weight-light">The</span>
                <span color='black'>Newsroom</span>
            </v-toolbar-title>
        </v-btn>
        <v-spacer></v-spacer>

        <v-btn flat depressed text-color="grey" to="/topics">
            <span color='grey'>Topics</span>
        </v-btn>

        <v-btn flat depressed text-color="grey" to="/trends">
            <span color='grey'>Trends</span>
        </v-btn>

        <v-menu offset-y>
            <v-btn flat slot="activator" color="grey">
                <v-icon left>expand_more</v-icon>
                <span>Account</span>
            </v-btn>
            <v-list>
                <v-list-tile v-for="link in unreg_links" :key="link.text" router :to="link.route">
                    <v-list-tile-title>{{ link.text }}</v-list-tile-title>
                </v-list-tile>
            </v-list>
        </v-menu>

    </v-toolbar>

</nav>
</template>

<script>
export default {
    data: () => ({
        drawer: false,
        unreg_links: [{
                icon: 'login',
                text: 'Log In',
                route: '/login'
            },
            {
                icon: 'register',
                text: 'Register',
                route: '/register'
            },
        ],
        reg_links: [{
                icon: 'mytrends',
                text: 'My Trends',
                route: '/mytrends'
            },
            {
                icon: 'logout',
                text: 'Log Out',
                route: '/logout'
            },
        ]
    }),
}
</script>

<style>

</style>
