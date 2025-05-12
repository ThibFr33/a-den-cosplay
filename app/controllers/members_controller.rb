# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :add_photo]
  before_action :set_member, only: [:edit, :update, :add_photo, :destroy_photo, :show]
  before_action :authorize_member!, only: [:edit, :update, :add_photo]
  before_action :authorize_admin, only: [:new, :create]


  def authorize_member!
    unless current_user.admin? || current_user == @member.user
      redirect_to members_path, alert: "Vous ne pouvez modifier que votre propre fiche."
    end
  end

  def index
    @members = Member.all
    @members = Member.order(pseudo: :asc)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
    @member.build_user
  end

  def create
    @member = Member.new(member_params)


    if @member.save
      redirect_to @member, notice: "Une nouvelle recrue fait son apparition"
    else
      # Pour voir les erreurs dans la vue `new`
      render :new, status: :unprocessable_entity
    end
  end


  def update
    @member = Member.find(params[:id])

    unless current_user.admin? || current_user == @member.user
      redirect_to root_path, alert: "Accès refusé."
      return
    end

    if @member.update(member_params.except(:photos))
      # 2. Puis on ajoute les nouvelles photos sans supprimer les anciennes
      if params[:member][:photos]
        @member.photos.attach(params[:member][:photos])
      end

      redirect_to @member, notice: "Profil mis à jour avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy_photo
    @member = Member.find(params[:id])
    photo = @member.photos.find(params[:photo_id])
    photo.purge
    redirect_to @member, notice: "Photo supprimée avec succès!"
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


  def show
    @member = Member.find(params[:id])
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
    @member = Member.find(params[:id])
  end

end
