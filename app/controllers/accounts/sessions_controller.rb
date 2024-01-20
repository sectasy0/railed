# frozen_string_literal: true

module Accounts
  # Controller responsible for handling user sessions, extending Devise's SessionsController.
  # Path: `/accounts/`
  class SessionsController < Devise::SessionsController
    before_action :configure_sign_in_params, only: [:create]

    include Recaptchable
    captcha_actions :create, :new

    # GET /accounts/sign_in
    # def new
    #   super
    # end

    # POST /accounts/sign_in
    # def create
    #   super
    # end

    # DELETE /accounts/sign_out
    # def destroy
    #   super
    # end

    protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
    end
  end
end
