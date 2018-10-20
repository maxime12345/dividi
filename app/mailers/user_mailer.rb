# frozen_string_literal: true

class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts = {})
    opts[:from] = 'Dividi'
    opts[:reply_to] = 'contact@dividi-project.pro'
    super
  end

  def reset_password_instructions(record, token, opts = {})
    opts[:from] = 'Dividi'
    opts[:reply_to] = 'maintenance@dividi-project.pro'
    super
  end
end
