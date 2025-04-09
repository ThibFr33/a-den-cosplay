# frozen_string_literal: true

class MembersController < ApplicationController
  def index
    @members = Member.all
    @members = Member.order(pseudo: :asc)
  end

  def show
    @member = Member.find(params[:id])
  end

  private

  def member_params
    params.require(:member).permit(:pseudo, :reseau_social, :presentation, photos: [])
  end
end
