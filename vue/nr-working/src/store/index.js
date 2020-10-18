import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// const URI = whatever we use for db

export default new Vuex.Store({
	state: {
		current_topic: null,
		popups: [],
		selected: []
	},
	mutations: {
		openTopic: (state) => (topic) => {
			state.current_topic = topic
		},
		nextTopic: (state) => (topic) => {
			state.popups.push(state.current_topic)
			state.current_topic = topic
		},
		previousTopic: (state) => {
			state.current_topic = state.popups.pop()
		},
		closeTopic: (state) => {
			state.current_topic = null
			state.popups = []
			state.dialog = false
		},
		addSelected: (state) => (topic) => {
			state.selected.push(topic)
		},
		removeSelected: (state) => (topic) => {
			const index = state.selected.findIndex(item => item.id === topic.id)
			state.selected.splice(index, 1)
		}
	},
	actions: {
		// fetchTopics() ---> to retrieve all topics in db
	},
	getters: {
		isRoot: (state) => {
			if (state.popups.length == 0) return true 
			return false
		},
		isSelected : (state) => (topic) => {
			if(state.selected.includes(topic)) {
				return true
			}
			return false
		}
	}
})