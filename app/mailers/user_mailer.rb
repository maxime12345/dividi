class UserMailer < Devise::Mailer

  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    headers["Custom-header"] = "Bar"
    opts[:from] = 'noreply@dividi-project.pro'
    super
  end

  def welcome(user)
    @user = user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Welcome to Dividi')
    # This will render a view in `app/views/user_mailer`!
  end
end
