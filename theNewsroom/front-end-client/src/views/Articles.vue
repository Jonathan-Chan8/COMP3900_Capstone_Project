<template>
    <div class="articles">
        <h1 class="subheading grey--text">Articles</h1>

        <div class="articles">
            <div 
                v-for="article of allArticles"
                :key="article.articleid"
                class="article-item"
            >
                <p> {{ article }} </p>
            </div>   
        </div>
    </div>
</template>

<script>
import ALL_ARTICLES from '../graphql/allArticles.gql'

export default {
    data () {
        return {
            // declare a variable in the Vue world that is prepared to hold the data
            allArticles: []
        }
    },
    apollo: {
        allArticles: ALL_ARTICLES
    }
}
</script>