# frozen_string_literal: true

class Event < ApplicationRecord
  validates :url, presence: true
end
