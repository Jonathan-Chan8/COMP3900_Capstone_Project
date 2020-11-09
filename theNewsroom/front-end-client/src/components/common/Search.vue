<template>
<div>
    <v-dialog d-flex elevation="0" v-model="show" width="500">
        <template v-slot:activator="{ on, attrs }">
            <v-text-field v-bind="attrs" @key.enter="on" dense rounded filled v-model="search" append-icon="mdi-magnify" label="Search for a topic" single-line hide-details />
        </template>

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
