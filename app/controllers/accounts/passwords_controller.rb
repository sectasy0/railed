# frozen_string_literal: true

module Accounts
  # Controller responsible for handling account password change.
  # Path: `/me/password/`
  class PasswordsController < ApplicationController
    # GET /me/password/edit
    def edit
      return account_using_oauth if current_account.oauth?

      render('accounts/passwords/edit')
    end

    # POST /me/password/update
    def update
      return account_using_oauth if current_account.oauth?

      unless current_account.valid_password?(update_params[:current_password])
        alert = I18n.t('controllers.passwords.current_incorrect')
        return redirect_to(accounts_passwords_edit_path, alert:)
      end

      return update_success if current_account.update(update_params)

      render(:edit, status: :unprocessable_entity)
    end

    private

    def update_params
      params.require(:account).permit(:current_password, :password, :password_confirmation)
    end

    def account_using_oauth
      redirect_to(root_path, alert: I18n.t('controllers.passwords_reset.account_using_oauth'))
    end

    def update_success
      bypass_sign_in(current_account)
      redirect_to(root_path, notice: I18n.t('controllers.passwords.change_success'))
    end
  end
end
