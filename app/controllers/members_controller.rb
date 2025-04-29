# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :add_photo]
  before_action :authorize_member!, only: [:edit, :update, :add_photo]

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

  def update
    @member = Member.find(params[:id])

    unless current_user.admin? || current_user == @member.user
      redirect_to root_path, alert: "Accès refusé."
      return
    end

    # 1. D'abord on met à jour les champs texte (sans les photos)
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



  def add_photo
  end

  def show
    @member = Member.find(params[:id])
  end

  private

  def member_params
    params.require(:member).permit(:pseudo, :reseau_social, :presentation, photos: [])
  end
end
