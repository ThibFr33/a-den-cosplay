class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
    @member = current_user.member
  end

  def update
    @user = current_user
    @member = current_user.member

    user_updated = @user.update(user_params)
    member_updated = @member.update(member_params)

    if user_updated && member_updated
      redirect_to member_path(@member), notice: "Profil mis à jour avec succès."
    else
      flash.now[:alert] = "Erreur lors de la mise à jour."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation).delete_if { |_k, v| v.blank? }
  end

  def member_params
    params.require(:member).permit(:pseudo, :description, :reseau_social)
  end
end
