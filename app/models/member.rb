# frozen_string_literal: true

class Member < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
end
