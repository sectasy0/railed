# frozen_string_literal: true

module Website
  module Server
    # == Schema Information
    #
    # Table name: servers
    #
    #  id           :uuid             not null, primary key
    #  website_id   :uuid             not null
    #  game_type_id :uuid             not null
    #  ip           :string(15)       not null
    #  port         :integer          not null
    #  created_at   :datetime         not null
    #  updated_at   :datetime         not null
    #
    class Base < ApplicationRecord
      self.table_name = 'servers'

      enum status: %i[unknown online offline]

      belongs_to :website, class_name: 'Website::Base'
      belongs_to :game_type, class_name: 'Website::GameType'

      validates :name, uniqueness: { scope: :website }, presence: true, length: { maximum: 120 }
      validates :ip, format: { with: Resolv::IPv4::Regex }
      validates :port, inclusion: 1024..65_535

      def status_label
        color = {
          unknown: 'text-gray-600 bg-gray-50',
          online: 'text-green-600 bg-green-50',
          offline: 'text-red-600 bg-red-50'
        }
        label = <<~HTML
          <span class="rounded-md px-3 py-1 text-sm font-semibold #{color[status.to_sym]}">
            #{status}
          </span>
        HTML
        label.html_safe
      end
    end
  end
end
