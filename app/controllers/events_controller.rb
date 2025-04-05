class EventsController < ApplicationController

  def index
    @events = Event.all
    @events = Event.order(start_date: :asc)
  end
end
