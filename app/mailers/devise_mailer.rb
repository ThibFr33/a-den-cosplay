class DeviseMailer < Devise::Mailer
  default reply_to: "no-reply.dragonkrayt.contact@gmail.com"

  default template_path: "devise/mailer"

  layout "mailer"
end
