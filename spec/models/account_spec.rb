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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'rails_helper'

RSpec.describe Account do
  subject(:account) { described_class.new }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_presence_of(:email) }

  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { is_expected.to allow_value('test@example.com').for(:email) }

  it { is_expected.not_to allow_value('invalid').for(:email) }

  it { is_expected.not_to allow_value('test@example').for(:email) }

  it { is_expected.not_to allow_value('@example.com').for(:email) }
end
