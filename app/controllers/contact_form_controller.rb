# frozen_string_literal: true

class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)

    if verify_recaptcha(model: @contact_form) && @contact_form.valid?
      UserMailer.user_email(@contact_form).deliver_now
      # ici tu pourrais envoyer un email ou faire autre chose
     redirect_to new_contact_form_path, notice: "Message envoyé avec succès."
    else
      render :new
    end

    # Perform any necessary actions with the form data
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:prenom, :nom, :email, :message)
  end
end
