class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @member = current_user.member
  end

  def update
    @user = current_user

    if @user.update(user_params)
      redirect_to member_path(@user.member), notice: 'Profil mis à jour avec succès.'
    else
      flash.now[:alert] = 'Erreur lors de la mise à jour.'
      render :edit, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation,
      member_attributes: [:id, :pseudo, :presentation, :reseau_social]
    ).delete_if { |_k, v| v.blank? }
  end
end
