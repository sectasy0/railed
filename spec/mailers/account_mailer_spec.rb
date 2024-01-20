# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountMailer, type: :mailer do
  describe 'password_reset' do
    let(:account) { accounts(:first) }
    let(:token) { 'abc123' }

    subject(:mail) { AccountMailer.password_reset(account, token) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Reset your password')
      expect(mail.to).to eq([account.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Hey there,')
      expect(mail.body.encoded).to include(account.email)
      expect(mail.body.encoded).to include(token)
      expect(mail.body.encoded).to include('Reset my password')
    end

    it 'should have enqueued mail' do
      expect do
        mail.deliver_later
      end.to have_enqueued_mail(AccountMailer, :password_reset).once
    end
  end
end
