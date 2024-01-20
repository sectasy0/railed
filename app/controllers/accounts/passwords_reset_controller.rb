# frozen_string_literal: true

module Accounts
  # Controller responsible for handling account password reset.
  # Path: `/password/`
  class PasswordsResetController < ApplicationController
    skip_before_action :authenticate_account!
    before_action :redirect_signed_id

    append_before_action :assert_reset_token_passed, only: :edit

    include Recaptchable
    captcha_actions :create, :new

    # GET /password/forgot
    def new; end

    # GET /password/reset
    def create
      render(:new, status: :unprocessable_entity) and return unless check_captcha
      return redirect_invalid_email unless create_params[:email]

      @account = Account.find_by(email: create_params[:email])
      return account_not_found if @account.nil?
      return account_using_oauth if @account.oauth?

      reset_account_password
      redirect_to(accounts_passwords_reset_password_forgot_path,
                  notice: I18n.t('controllers.passwords_reset.email_sent'))
    end

    # GET /password/edit?reset_password_token=abcdef
    def edit
      @account = Account.new
      @account.reset_password_token = params[:reset_password_token]
    end

    # PUT /password/update
    def update
      @account = Account.reset_password_by_token(update_params)
      session[:account] = @account

      if @account.errors.empty?
        @account.unlock_access! if unlockable?(@account)
        @account.after_database_authentication
        sign_in(Account, @account)
        redirect_to(root_path, notice: I18n.t('controllers.passwords_reset.changed'))
      else
        render(:edit, status: :unprocessable_entity)
      end
    end

    private

    def create_params
      params.require(:account).permit(:email)
    end

    # Check if proper Lockable module methods are present & unlock strategy
    # allows to unlock resource on password reset
    def unlockable?(resource)
      resource.respond_to?(:unlock_access!) &&
        resource.respond_to?(:unlock_strategy_enabled?) &&
        resource.unlock_strategy_enabled?(:email)
    end

    def redirect_signed_id
      redirect_to(root_path) if current_account.present?
    end

    def assert_reset_token_passed
      return unless params[:reset_password_token].blank?

      alert = I18n.t('controllers.passwords_reset.invalid_token')
      redirect_to(new_account_session_path, alert:)
    end

    def update_params
      params.require(:account).permit(:password, :password_confirmation, :reset_password_token)
    end

    def redirect_invalid_email
      redirect_to(accounts_passwords_reset_password_forgot_path,
                  alert: I18n.t('controllers.passwords_reset.email_empty'))
    end

    def account_not_found
      redirect_to(accounts_passwords_reset_password_forgot_path,
                  alert: I18n.t('controllers.passwords_reset.account_not_found'))
    end

    def account_using_oauth
      redirect_to(accounts_passwords_reset_password_forgot_path,
                  alert: I18n.t('controllers.passwords_reset.account_using_oauth'))
    end

    def reset_account_password
      raw, hashed = Devise.token_generator.generate(Account, :reset_password_token)
      @account.update(reset_password_token: hashed, reset_password_sent_at: Time.now.utc)
      AccountMailer.password_reset(@account, raw).deliver_now
    end
  end
end
