import { Template } from "webpack/lib/dependencies/ConstDependency";
import consumer from "./consumer"

const eventChannel = consumer.subscriptions.create("EventChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    const eventDisplay = document.querySelector('#new-events')
    eventDisplay.insertAdjacentHTML('beforeend', this.template(data))
    console.log(data)
  },

  template(data) {
    return `<div class="new-event">
              <p>New event created by ${data.creator.username}: ${data.name}</p>
            </div>`
  }
});
