import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

// const URI = whatever we use for db

export default new Vuex.Store({
	state: {
		current_topic: '',
		saved: [{
				title: "U.S. Politics",
				topics: ['Joe Biden', 'U.S. Election', 'Donald Trump', 'Supreme Court'],
			},
			{
				title: "Coronavirus",
				topics: ['Coronavirus', 'Vaccine', 'Australia', 'New Zealand', 'Melbourne'],
			},
			{
				title: "World Events",
				topics: ['Coronavirus', 'U.S. Election', 'Californian Bushfires', 'New Zealand', 'Brexit'],
			}
		],
		popups: [],
		selected: [],
		related: ['Scott Morrison', 'Iran', 'Brexit', 'Vaccine', 'ACT']

		
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
		// openArticle(state, article) {
		// 	state.current_article = article
		// },
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

		setSelected(state, selection) {
			state.selected = selection.map(a => a)
		},
		
		saveTrend(state, name) {
			var trend = state.selected.map(a => a)			
			state.saved.push({
				title: name,
				topics: trend
			})
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
			return state.selected.length
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

		getRelated: state => {
			// This will return the related topics based on the current topic (for popups) or selected topics (for trends)
			return state.related
		},

		getPopups: state => {
			return state.popups
		},

		getSaved: state => {
			return state.saved
		}

	}
})
