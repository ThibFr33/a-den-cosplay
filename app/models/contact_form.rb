# frozen_string_literal: true

# app/models/contact.rb
class ContactForm
  include ActiveModel::Model

  attr_accessor :prenom, :nom, :email, :message

  validates :prenom, presence: true
  validates :nom, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true, length: { minimum: 10 }
end
