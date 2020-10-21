import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// const URI = whatever we use for db

export default new Vuex.Store({
	state: {
		current_topic: '',
		popups: [],
		selected: []
	},

	mutations: {
		addSelected(state, topic) {
			state.selected.push(topic)
		},
		removeSelected(state, topic) {
			let index = state.selected.findIndex(item => item == topic)
			state.selected.splice(index, 1)
		},
		openTopic(state, topic) {
			state.current_topic = topic

		},

		nextTopic(state, topic) {
			state.popups.push(state.current_topic)
			state.current_topic = topic
		},
		previousTopic(state) {
			state.current_topic = state.popups.pop()
		},
		
		closeTopic(state) {
			state.current_topic = null
			state.popups = []
		},

		emptySelected(state) {
			state.selected = []
		},
		setSelected(state, topics) {
			state.emptySelected()
			var i
			for (i = 0; i < topics.length; i++) {
				state.addSelected(topics[i])
			}
		}
	},

	actions: {
		// fetchTopics() ---> to retrieve all topics in db
	},
	
	getters: {
		isRoot: state => {
			if (state.popups.length === 0) return true
			return false
		},

		numSelected: state => {
			let num = 0
			state.selected.forEach(num += 1)
			return num
		},

		isSelected: state => {
			if (state.selected.includes(state.current_topic)) {
				return true
			}
			return false
		},

		getSelected: state => {
			return state.selected
		},

		getPopups: state => {
			return state.popups
		}

	}
})
