class ApplicationMailer < ActionMailer::Base
  helper :application

  append_view_path Rails.root.join('app/views/mailers')

  default from: -> { "#{sender_name} <#{sender_email}>" }
  layout 'mailer'

  def sender_name
    Credentials.get(:mail, :sender_name)
  end

  def sender_email
    Credentials.get(:mail, :sender_email)
  end
end
