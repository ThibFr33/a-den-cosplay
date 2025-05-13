# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    today = Date.current

    @past_events = Event.past
    @upcoming_events = Event.upcoming
    @events = Event.all
    @events = Event.order(start_date: :asc)
  end
end
