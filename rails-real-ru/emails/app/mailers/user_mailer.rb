# frozen_string_literal: true

class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation
    @user = params[:user]
    @url  = confirm_user_url(confirmation_token: @user.confirmation_token)
    mail(to: @user.email)
  end
end
