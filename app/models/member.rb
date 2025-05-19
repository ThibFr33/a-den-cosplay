# frozen_string_literal: true

class Member < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  accepts_nested_attributes_for :user
  validates :user_id, uniqueness: true
  validates :pseudo, uniqueness: true
end
