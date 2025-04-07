class MembersController < ApplicationController

  def index
    @members = Member.all
    @members = Member.order(pseudo: :asc)
  end

  def show
    @member = Member.find(params[:id])
  end
end
