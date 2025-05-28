# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :add_photo, :destroy_photo]
  before_action :set_member, only: [:edit, :update, :add_photo, :destroy_photo, :show]
  before_action :authorize_member!, only: [:edit, :update, :add_photo, :destroy_photo]
  before_action :authorize_admin, only: [:new, :create]
  before_action :authorize_edit!, only: [:edit, :update]




  def index
    @members = Member.all
    @members = Member.order(pseudo: :asc)
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
    @member.build_user
  end

  def create
    if params[:member][:user_attributes][:password].blank?
      generated_password = Devise.friendly_token.first(12)
      params[:member][:user_attributes][:password] = generated_password
      params[:member][:user_attributes][:password_confirmation] = generated_password
    end

    @member = Member.new(member_params)
    if @member.save
      if generated_password
        UserMailer.with(user: @member.user, password: generated_password).welcome.deliver_later
      else
        UserMailer.with(user: @member.user).welcome.deliver_later
      end

      redirect_to @member, notice: "Une nouvelle recrue fait son apparition. Un mail de connexion a été envoyé."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      redirect_to @member, notice: "Profil membre mis à jour avec succès."
    else
      flash.now[:alert] = "Erreur lors de la mise à jour."
      render :edit, status: :unprocessable_entity
    end
  end



def destroy_photo
    attachment = @member.photos.attachments.find(params[:photo_id])
    attachment.purge
    respond_to do |format|
      format.html       { redirect_to @member, notice: "Photo supprimée !" }
      format.turbo_stream { flash.now[:notice] = "Photo supprimée !" }
    end
end



  def add_photo

    @member = Member.find(params[:id])

    if params[:member] && params[:member][:photos].present?
      @member.photos.attach(params[:member][:photos])
      redirect_to @member, notice: "Photos ajoutées !"
    else
      redirect_to @member, alert: "Aucune photo sélectionnée."
    end
  end



  private

  def authorize_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Accés Interdit !"
    end
  end

  def member_params
    params.require(:member).permit(:pseudo, :reseau_social, :presentation, :role, photos: [], user_attributes: [:email, :password, :password_confirmation])
  end

  def set_member
    member_id = params[:member_id] || params[:id]
    @member   = Member.find(member_id)
  end

  def authorize_member!
    unless current_user.admin? || current_user == @member.user
      redirect_to members_path, alert: "Vous ne pouvez modifier que votre propre fiche."
    end
  end

  def authorize_edit!
    member = Member.find(params[:id])
    unless current_user.admin? || current_user == member.user
      redirect_to root_path, alert: "Accès refusé."
    end
  end

end
