# frozen_string_literal: true

class User < ApplicationRecord
  has_one :member, dependent: :destroy
  accepts_nested_attributes_for :member
  validate :password_complexity

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :validatable,
         :confirmable, :timeoutable


  def admin?
    self.admin == true
  end


private

  def password_complexity
    return if password.blank?

    unless password =~ /[A-Z]/
      errors.add :password, "doit contenir au moins une lettre majuscule"
    end

    unless password =~ /\d/
      errors.add :password, "doit contenir au moins un chiffre"
    end

    unless password =~ /[^A-Za-z0-9]/
      errors.add :password, "doit contenir au moins un caractère spécial"
    end
  end

end
