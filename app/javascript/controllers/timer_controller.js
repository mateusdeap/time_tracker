import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  initialize() {
    const csrfToken = document.querySelector("meta[name='csrf-token']").content;
    const id = this.element.dataset.id
    const timerControl = document.querySelector(`#timer-control-${id}`)
    const elapsedTime = document.querySelector(`#elapsed_time_${id}`)

    fetch(`/timers/${id}`, {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": csrfToken
      }
    })
    .then(response => response.json())
    .then(data => {
      this.elapsedTime = data.elapsed_time;

      if (timerControl.getAttribute("data-action") == "timer#start") {
        this.running = false;
      } else {
        elapsedTime.innerText = this.formattedElapsedTime();
        this.running = true;
        setTimeout(() => this.tic(), 1000);
      }
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
      .then(response => response.json())
      .then(data => {
        this.elapsedTime = data.elapsed_time;
        elapsedTime.innerText = this.formattedElapsedTime();
        timerControl.innerText = "Stop";
        timerControl.setAttribute("data-action", "timer#stop");
        this.running = true;
        setTimeout(() => this.tic(), 1000);
      });
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
        this.elapsedTime = data.elapsed_time;
        elapsedTime.innerText = this.formattedElapsedTime();
        timerControl.textContent = "Start"
        timerControl.setAttribute("data-action", "timer#start")
        this.running = false;
      });
  }
  
  tic() {
    if (!this.running) return;
    
    const id = this.element.dataset.id
    const elapsedTime = document.querySelector(`#elapsed_time_${id}`)

    this.elapsedTime += 1;
    elapsedTime.innerText = this.formattedElapsedTime();
    setTimeout(() => this.tic(), 1000);
  }
  
  formattedElapsedTime() {
    const hours = Math.floor(this.elapsedTime / 3600);
    const minutes = Math.floor((this.elapsedTime % 3600) / 60);
    const seconds = this.elapsedTime % 60;

    return `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }
}
