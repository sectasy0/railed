# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :uuid             not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  locale                 :string           default("en")
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  role                   :integer          default("user")
#  name                   :string
#  uid                    :string
#  provider               :string
#  avatar                 :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Account < ApplicationRecord
  include Avatarable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :trackable,
         :omniauthable, omniauth_providers: [:discord]

  mount_uploader :avatar, Accounts::AvatarUploader

  enum role: %i[admin user]

  attr_accessor :current_password

  validates :name, presence: true

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |account|
      account.attributes = {
        provider: auth.provider,
        uid: auth.uid,
        name: auth.info.name,
        email: auth.info.email,
        password: Devise.friendly_token[0, 20],
        remote_avatar_url: remote_available(auth) ? auth.info.image : nil
      }
    end
  end

  def self.remote_available(auth)
    return false unless auth&.info&.image.present?

    Faraday.get(auth.info.image).status == 200
  end

  private_class_method(%i[remote_available])

  def oauth?
    provider && uid
  end
end
