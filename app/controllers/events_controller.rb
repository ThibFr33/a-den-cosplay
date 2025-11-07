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

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to @event, notice: "L'événement a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
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

  def destroy_photo
    attachment = @event.photos.attachments.find(params[:photo_id])
    attachment.purge
    respond_to do |format|
      format.html { redirect_to @event, notice: "Photo supprimée !" }
      format.turbo_stream { flash.now[:notice] = "Photo supprimée !" }
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :localisation, :description, :url, :start_date, :end_date, photos: [])
  end


end
