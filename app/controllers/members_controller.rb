# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :add_photo, :destroy_photo]
  before_action :set_member, only: [:edit, :update, :add_photo, :destroy_photo, :show, :destroy]
  before_action :authorize_member!, only: [:edit, :update, :add_photo, :destroy_photo]
  before_action :authorize_admin, only: [:new, :create, :destroy]
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
    email = member_params.dig(:user_attributes, :email).to_s.strip

    user = User.invite!(email: email)
    if user.invalid?
      @member = Member.new; @member.build_user(email: email)
      @member.errors.add(:base, user.errors.full_messages.to_sentence)
      return render :new, status: :unprocessable_entity
    end
    attrs   = member_params.to_h.except("user_attributes")
    @member = Member.new(attrs.merge(user: user))

    if @member.save
      redirect_to @member, notice: "Invitation envoyée."
    else
      @member.build_user(email: email) unless @member.user
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

  def destroy
    # petites sécurités utiles
    if current_user == @member.user
      return redirect_to @member, alert: "Vous ne pouvez pas vous supprimer vous-même ici."
    end
    if @member.user.admin? && User.where(admin: true).count <= 1
      return redirect_to @member, alert: "Impossible de supprimer le dernier administrateur."
    end
    user = @member.user
    if user.destroy   # <= une seule ligne fait tout le boulot
      redirect_to members_path, notice: "Membre et compte utilisateur supprimés."
    else
      redirect_to @member, alert: user.errors.full_messages.to_sentence
    end
  end

  def destroy_photo
    attachment = @member.photos.attachments.find(params[:photo_id])
    attachment.purge
    respond_to do |format|
      format.html { redirect_to @member, notice: "Photo supprimée !" }
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
    params.require(:member).permit(:pseudo, :reseau_social, :presentation, :role, photos: [], user_attributes: [:email])
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

