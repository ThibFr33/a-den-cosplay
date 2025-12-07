class EventsController < ApplicationController
  before_action :set_event, except: [:index, :new, :create]

  def index
    @past_events = Event.past
    @upcoming_events = Event.upcoming
    @events = Event.order(start_date: :asc)
    @expiring_events = Event.expiring_soon
  end

  def show
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

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "L'événement a bien été mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.photos.each(&:purge)
    @event.destroy

    redirect_to events_path, notice: "L'événement a été supprimé avec succès."
  end


  def add_photo
    if params[:event] && params[:event][:photos].present?
      @event.photos.attach(params[:event][:photos])
      redirect_to @event, notice: "Photos ajoutées !"
    else
      redirect_to @event, alert: "Aucune photo sélectionnée."
    end
  end

  def destroy_photo
    attachment = @event.photos.find(params[:photo_id])
    attachment.purge
    redirect_to @event, notice: "Photo supprimée !"
  end

  private

  def event_params
    params.require(:event).permit(:name, :localisation, :description, :url, :start_date, :end_date, photos: [])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
