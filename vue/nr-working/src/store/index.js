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
		addSelected({ selected }, topic) {
			selected.push(topic)
		},
		removeSelected({ selected }, topic) {
			const topicIndex = selected.findIndex(item => item.id === topic.id)
			selected.splice(topicIndex, 1)
		},
		openTopic(topic) {
			this.state.current_topic = topic
		},

		nextTopic({popups}, topic) {
			popups.push(this.state.current_topic)
			this.state.current_topic = topic
		},
		previousTopic({popups}) {
			this.state.current_topic = popups.pop()
		},
		closeTopic() {
			this.state.current_topic = null
			this.state.popups = []
		},
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
		}
	}
})
