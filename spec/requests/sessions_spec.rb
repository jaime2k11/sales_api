require 'rails_helper'

RSpec.describe SessionsController, type: :request do

  describe 'login' do
    let(:user) { create(:user) }

    it 'autentica con credenciales válidas' do
      post '/login', params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:ok)
    end

    it 'falla con credenciales inválidas' do
      post '/login', params: { email: user.email, password: 'wrongpassword' }
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
