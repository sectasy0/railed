# frozen_string_literal: true

module Website
  module Server
    # == Schema Information
    #
    # Table name: products
    #
    #  id          :uuid             not null, primary key
    #  server_id   :uuid             not null
    #  stripe_id   :string(18)
    #  name        :string(120)
    #  description :string(255)
    #  amount      :integer
    #  price       :integer
    #  image       :string(255)
    #  created_at  :datetime         not null
    #  updated_at  :datetime         not null
    #
    class Product < ApplicationRecord
      belongs_to :server, class_name: 'Website::Server::Base'

      validates :stripe_id, presence: true, length: { minimum: 18, maximum: 18 }
      validates :name, :amount, :price, presence: true
    end
  end
end
