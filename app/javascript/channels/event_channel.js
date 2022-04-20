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
    const eventDisplay = document.querySelector('#id')
    eventDisplay.insertAdjacentHTML('afterbegin', this.template(data))
  },

  template(data) {
    return `<p>New event created by ${data.creator.username}: ${data.name}. Refresh the page to see all new events.</p>`
  }
});
