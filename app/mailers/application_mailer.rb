# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: '"Dragon Krayt Cosplay" <no-reply.dragonkrayt.contact@gmail.com>',
          reply_to: 'no-reply.dragonkrayt.contact@gmail.com'

  layout 'mailer'
end
