# frozen_string_literal: true

class Event < ApplicationRecord
  validates :name, :localisation, :description, :url, :start_date, :end_date, presence: true
  has_many_attached :photos
  scope :past,     -> { where('start_date < ?', Date.current).order(start_date: :desc) }
  scope :upcoming, -> { where('start_date >= ?', Date.current).order(start_date: :asc) }
  scope :expired, -> { where("end_date <= ?", 2.years.ago) }
  scope :expiring_soon, -> {
    where(end_date: (2.years.ago + 1.month)..(2.years.ago))
  }



end
