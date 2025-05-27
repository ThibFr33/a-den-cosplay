# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    today = Date.current

    @past_events = Event.past
    @upcoming_events = Event.upcoming
    @events = Event.all
    @events = Event.order(start_date: :asc)
  end

  def show
    @event = Event.find(params[:id])
  end

  def add_photo

    @event = Event.find(params[:id])

    if params[:event] && params[:event][:photos].present?
      @event.photos.attach(params[:event][:photos])
      redirect_to @event, notice: "Photos ajoutées !"
    else
      redirect_to @event, alert: "Aucune photo sélectionnée."
    end
  end

end
