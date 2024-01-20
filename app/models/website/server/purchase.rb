# frozen_string_literal: true

module Website
  module Server
    # == Schema Information
    #
    # Table name: purchases
    #
    #  id               :uuid             not null, primary key
    #  server_id        :uuid             not null
    #  product_id       :uuid             not null
    #  buyer_email      :string(120)
    #  buyer_name       :string(120)
    #  discount         :integer
    #  transaction_hash :string(36)       not null
    #  created_at       :datetime         not null
    #  updated_at       :datetime         not null
    #
    class Purchase < ApplicationRecord
      belongs_to :server, class_name: 'Website::Server::Base'
      belongs_to :product, class_name: 'Website::Server::Product'

      validates :buyer_email, presence: true, format: { with: Devise.email_regexp }
      validates :buyer_name, :transaction_hash, presence: true
      validates :discount, numericality: { greater_than_or_equal_to: 0 }
    end
  end
end
