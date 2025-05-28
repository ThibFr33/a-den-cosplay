class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]

  def user_email(contact_form)
    @contact_form = contact_form

    mail(
      to: ENV["CONTACT_RECIPIENT_EMAIL"],
      subject: "Nouveau message de contact",
      reply_to: @contact_form.email
    )
  end

  def send_password
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Votre mot de passe temporaire")
  end
end
