class UserMailer < ApplicationMailer
  default to: "thibs.cha@gmail.com"

  def user_email(contact_form)
    @contact_form = contact_form

    puts "DEBUG: prenom = #{@contact_form.prenom}, nom = #{@contact_form.nom}"

    mail(
      from: @contact_form.email,
      subject: "Nouveau message du formulaire de contact"
    )
  end
end
