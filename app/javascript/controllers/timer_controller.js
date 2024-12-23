import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  connect() {
		console.log("Connected")
  }

	stop() {
		const csrfToken = document.querySelector("meta[name='csrf-token']").content;
		const id = this.element.dataset.id
		const elapsedTime = document.querySelector(`#elapsed_time_${id}`)
		const timerControl = document.querySelector(`#timer-control-${id}`)

		fetch(`/timers/${id}`, {
			method: "PATCH",
			headers: {
				"Content-Type": "application/json",
				"Accept": "application/json",
				"X-CSRF-Token": csrfToken
			},
			body: JSON.stringify({ stop: "true" })
		})
			.then(response => response.json())
			.then(data => {
				elapsedTime.textContent = data.elapsed_time
				timerControl.textContent = "Start"
				timerControl.setAttribute("data-action", "timer#start")
			});
	}

	start() {
		const csrfToken = document.querySelector("meta[name='csrf-token']").content;
		const id = this.element.dataset.id
		const elapsedTime = document.querySelector(`#elapsed_time_${id}`)
		const timerControl = document.querySelector(`#timer-control-${id}`)

		fetch(`/timers/${id}`, {
			method: "PATCH",
			headers: {
				"Content-Type": "application/json",
				"Accept": "application/json",
				"X-CSRF-Token": csrfToken
			},
			body: JSON.stringify({ start: "true" })
		})
			.then(response => {
				response.json()
			})
			.then(data => {
				elapsedTime.innerText = "Timer running..."
				timerControl.innerText = "Stop"
				timerControl.setAttribute("data-action", "timer#stop")
			});
	}
}
