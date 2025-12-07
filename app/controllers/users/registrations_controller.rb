class Users::RegistrationsController < Devise::RegistrationsController
  def edit
    redirect_to edit_profile_path
  end
end
