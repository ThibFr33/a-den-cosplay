class CleanupEventsJob < ApplicationJob
  queue_as :default

  def perform
    Event.expired.find_each do |event|
      event.photos.each(&:purge)
      event.destroy
    end
  end
end
