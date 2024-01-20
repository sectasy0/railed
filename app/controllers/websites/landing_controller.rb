# frozen_string_literal: true

module Websites
  # Controller responsible for handling user websites. extending Websites::WebsitesController.
  # Path: `/<website_name>`
  class LandingController < WebsitesController
    # GET /<website_name>/
    def index; end

    # GET /<website_name>/news
    def news; end

    # GET /<website_name>/terms
    def terms; end
  end
end
