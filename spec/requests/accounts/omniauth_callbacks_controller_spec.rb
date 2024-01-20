# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Accounts::OmniauthCallbacksController, type: :request do
  describe '#discord' do
    let(:auth_hash) do
      OmniAuth::AuthHash.new(
        provider: 'discord',
        uid: '940987618345254912',
        info: {
          email: 'fakeemail@gmail-fake.com',
          username: 'David',
          image: 'https://cdn.discordapp.com/avatars/940987618345254912/c62c9b46dc9e877fff993bbe56ee7452'
        },
        credentials: {
          token: 'abcdefgh12345',
          refresh_token: '12345abcdefgh',
          expires_at: DateTime.now
        }
      )
    end

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:discord] = auth_hash
    end

    after do
      OmniAuth.config.test_mode = false
    end

    it 'should login with omniauth' do
      avatar_url_pattern = Regexp.new('https://[0-9]+.[0-9]+.[0-9]+.[0-9]+/avatars/940987618345254912/c62c9b46dc9e877fff993bbe56ee7452')

      stub_request(:get, 'https://cdn.discordapp.com/avatars/940987618345254912/c62c9b46dc9e877fff993bbe56ee7452')
        .to_return(body: File.read('spec/fixtures/discord_avatar.png'), headers: { 'Content-Type': 'image/png' })

      stub_request(:get, avatar_url_pattern)
        .to_return(body: File.read('spec/fixtures/discord_avatar.png'), headers: { 'Content-Type': 'image/png' })

      expect do
        get account_discord_omniauth_callback_path, params: { omniauth_auth: auth_hash }
      end.to change(Account, :count).by(1)

      oauth_account = Account.find_by(uid: '940987618345254912')
      expect(response).to redirect_to(controller.after_sign_in_path_for(oauth_account))
      expect(controller.current_account).to eq(oauth_account)
    end
  end
end
