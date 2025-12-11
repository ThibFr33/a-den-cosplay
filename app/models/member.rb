# frozen_string_literal: true

class Member < ApplicationRecord
  has_many_attached :photos
  belongs_to :user
  accepts_nested_attributes_for :user
  validates :user_id, uniqueness: true
  validates :pseudo, uniqueness: true
  before_save :capitalize_pseudo

private

  def capitalize_pseudo
    return if pseudo.blank?

    # baisse tout puis remonte les bonnes lettres
    self.pseudo = pseudo.downcase.gsub(/(?:^|[ '\-])([a-z])/) { $1.upcase }
  end

end
