# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LandingController, type: :request do
  describe 'GET #index' do
    it 'renders the index template' do
      get root_path
      expect(response).to render_template(root_path)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #contact' do
    it 'renders the contact template' do
      get contact_path
      expect(response).to render_template(:contact)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #send_message' do
    context 'with valid parameters' do
      it 'sends a message and redirects to root_path' do
        expect do
          post contact_send_path, params: {
            contact: { email: 'valid@email.com', subject: 'asdasdasd', message: 'asdasdas' }
          }
        end.to have_enqueued_mail(RaileyMailer, :contact).once

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq(I18n.t('controllers.landing.contact.sent'))
      end
    end

    context 'with invalid email' do
      it 'does not send a message and redirects to contact_path' do
        expect do
          post contact_send_path, params: {
            contact: { email: 'invalid_email', subject: 'asdasdasd', message: 'asdasdas' }
          }
        end.to_not have_enqueued_mail(RaileyMailer, :contact).once

        expect(response).to redirect_to(contact_path)
        expect(flash[:alert]).to eq(I18n.t('controllers.landing.contact.invalid_email'))
      end
    end
  end
end
