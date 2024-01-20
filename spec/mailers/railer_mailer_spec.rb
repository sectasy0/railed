# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RaileyMailer, type: :mailer do
  describe '#contact' do
    let(:form_data) { { name: 'John Doe', email: 'john@example.com', message: 'Hello!' } }

    it 'sends a contact email' do
      mail = RaileyMailer.contact(form_data)

      expect(mail.subject).to eq(I18n.t('mailers.railey_mailer.contact.subject'))
      expect(mail.from).to eq(['from@example.com'])

      expect(mail.body.encoded).to include('You have received a new message from the contact form:')
    end
  end
end
