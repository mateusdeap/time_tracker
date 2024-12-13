import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  connect() {
		console.log("Connected")
  }

	stop() {
		const csrfToken = document.querySelector("meta[name='csrf-token']").content;
		const id = this.element.dataset.id
		const timeElapsed = document.querySelector(`#time_elapsed_${id}`)

		fetch(`/entries/${id}`, {
			method: "PATCH",
			headers: {
				"Content-Type": "application/json",
				"Accept": "application/json",
				"X-CSRF-Token": csrfToken
			},
			body: JSON.stringify({ entry: { stop: new Date().toString() } })
		})
			.then(response => response.json())
			.then(data => {
				timeElapsed.innerText = data.time_elapsed
			});
	}
}
