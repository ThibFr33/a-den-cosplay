# frozen_string_literal: true

class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)

    if verify_recaptcha(model: @contact_form) && @contact_form.valid?
      UserMailer.user_email(@contact_form).deliver_now
     redirect_to new_contact_form_path, notice: "Message envoyé avec succès."
    else
      flash.now[:alert] = "Le formulaire n'a pas pu être envoyé. Vérifiez les erreurs."
      render :new
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:prenom, :nom, :email, :message)
  end
end
