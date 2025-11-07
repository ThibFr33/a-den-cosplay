# frozen_string_literal: true

class User < ApplicationRecord
  has_one :member, dependent: :destroy
  accepts_nested_attributes_for :member

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable


  def admin?
    self.admin == true
  end
end
