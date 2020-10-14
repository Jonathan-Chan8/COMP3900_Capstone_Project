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

            <!-- Only shown if not logged in -->
            <template v-if="!auth">
                <v-btn text v-for="item in unreg_links" :key="item.icon" :to="item.route" depressed>{{ item.title }}
                </v-btn>
            </template>

            <!-- Only shown if logged in -->
            <v-menu v-if="auth" offset-y>
                <template v-slot:activator=" { on }">
                    <v-btn text v-on="on">
                        <span>My Account</span>
                    </v-btn>
                </template>
                <v-list class="responsiveMenu">
                    <v-list-item text v-for="item in reg_links" :key="item.icon" :to="item.route" depressed>{{ item.title }}
                    </v-list-item>
                </v-list>
            </v-menu>
        </v-toolbar-items>

        <div class="d-md-none">
            <v-menu>
                <template v-slot:activator="{ on }">
                    <v-app-bar-nav-icon v-on="on"></v-app-bar-nav-icon>
                </template>
                <v-list class="responsiveMenu">
                    <!-- Always shown -->

                    <v-list-item text v-for="item in menu" :key="item.icon" :to="item.route" depressed>{{ item.title }}
                    </v-list-item>

                    <!-- Only shown if not logged in -->
                    <v-list-item text v-for="item in unreg_links" :key="item.icon" :to="item.route" depressed>{{ item.title }}
                    </v-list-item>

                    <!-- Only shown if logged in -->
                    <v-list-item text v-for="item in reg_links" :key="item.icon" :to="item.route" depressed>{{ item.title }}
                    </v-list-item>
                </v-list>
            </v-menu>
        </div>

    </v-toolbar>
</v-container>
</template>

<script>
export default {
    name: "Header",
    data: () => ({
        auth: true,
        drawer: false,
        unreg_links: [{
                icon: 'login',
                title: 'Log In',
                route: '/login'
            },
            {
                icon: 'register',
                title: 'Register',
                route: '/register'
            }
        ],
        reg_links: [{
                icon: 'mytrends',
                title: 'My Saved Trends',
                route: '/mytrends'
            },
            {
                icon: 'logout',
                title: 'Log Out',
                route: '/logout'
            }
        ],
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
