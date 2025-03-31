class Event < ApplicationRecord
  validates :url, presence: true
end
