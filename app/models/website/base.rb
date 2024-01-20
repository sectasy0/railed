# frozen_string_literal: true

module Website
  # == Schema Information
  #
  # Table name: websites
  #
  #  id                :uuid             not null, primary key
  #  name              :string
  #  description       :text
  #  account_id        :uuid
  #  discord_invite    :string
  #  additional_emails :text
  #  created_at        :datetime         not null
  #  updated_at        :datetime         not null
  #
  class Base < ApplicationRecord
    self.table_name = 'websites'

    belongs_to :owner, class_name: 'Account', foreign_key: :account_id

    validates :name, :description, presence: true

    validate :validate_discord_invite_format, if: -> { discord_invite.present? }

    has_many :servers, class_name: 'Website::Server::Base', foreign_key: :website_id, dependent: :destroy

    private

    def validate_discord_invite_format
      pattern = %r{(https://(www\.)?(discord\.gg|discord\.com/invite)/[a-zA-Z0-9]+)}
      return if discord_invite.match?(pattern)

      errors.add(:discord_invite, I18n.t('models.website.validations.incorrect_invite'))
    end
  end
end
