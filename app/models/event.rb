# frozen_string_literal: true

class Event < ApplicationRecord
  validates :url, presence: true
  scope :past,     -> { where('start_date < ?', Date.current).order(start_date: :desc) }
  scope :upcoming, -> { where('start_date >= ?', Date.current).order(start_date: :asc) }

end
