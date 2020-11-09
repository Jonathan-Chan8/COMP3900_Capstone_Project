<template>
<div>
    <v-dialog d-flex elevation="0" v-model="show" width="500">

        <v-card>

        </v-card>
    </v-dialog>
</div>
</template>

<script>
export default {
    data: () => ({
        show: false
    }),

    props: {
        value: Boolean
    },

    compute: {
        show: {
            get() {
                return this.value
            },
            set(value) {
                this.$emit('input', value)
            }
        }
    },

    methods: {
        close() {
            this.show = false
        }
    },
}
</script>
