# frozen_string_literal: true

# Controller responsible for handling main app locales
class HomeController < ApplicationController
  skip_before_action :authenticate_account!

  def index; end

  ##
  # GET /language/:locale
  #
  def change_locale
    assign_current_locale(params)
    redirect_back(fallback_location: root_path)
  end

  private

  def assign_current_locale(params)
    return unless I18n.available_locales.map(&:to_s).include?(params[:locale])

    if account_signed_in?
      current_account.locale = params[:locale]
      current_account.save(validate: false)
    else
      cookies[:locale] = params[:locale]
    end
    I18n.locale = params[:locale]
  end
end
