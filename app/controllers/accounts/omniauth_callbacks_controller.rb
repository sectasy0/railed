# frozen_string_literal: true

module Accounts
  # Controller responsible for handling OmniAuth authentication callbacks for user accounts
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :authenticate_account!

    # GET|POST /accounts/auth/discord/callback
    def discord
      @account = Account.from_omniauth(request.env['omniauth.auth'])
      sign_in(:account, @account)
      redirect_to(after_sign_in_path_for(@account))
    end
  end
end
