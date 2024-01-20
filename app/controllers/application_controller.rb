# frozen_string_literal: true

# Base application controller
class ApplicationController < ActionController::Base
  include ApplicationHelper

  before_action :authenticate_account!
  before_action :set_locale

  helper_method :account_signed_in?
  helper_method :current_account

  def after_sign_out_path_for(_)
    new_account_session_path
  end

  def after_sign_in_path_for(_)
    dashboard_home_index_path
  end

  private

  ##
  # sets current_account locale
  #
  def set_locale
    I18n.locale = current_account&.locale || cookies[:locale] || :en
  end
end
