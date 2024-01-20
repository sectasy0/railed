# frozen_string_literal: true

module Websites
  # Main websites controller
  class WebsitesController < ActionController::Base
    helper_method :account_signed_in?
    helper_method :current_account
  end
end
