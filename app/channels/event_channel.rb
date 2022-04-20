class EventChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "event"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def receive(data)
  end
end
