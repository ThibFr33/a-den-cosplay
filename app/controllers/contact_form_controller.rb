# frozen_string_literal: true

class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)

    if @contact_form.valid?
      # ici tu pourrais envoyer un email ou faire autre chose
      flash[:notice] = 'Message envoyé avec succès.'
      redirect_to new_contact_path
    else
      render :new
    end
    @prenom = params[:contact_form][:prenom]
    @nom = params[:contact_form][:nom]
    @email = params[:contact_form][:email]
    @message = params[:contact_form][:message]

    # Perform any necessary actions with the form data
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:prenom, :nom, :email, :message)
  end
end
