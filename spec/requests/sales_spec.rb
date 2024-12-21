# Pruebas para controller Sales
require 'rails_helper'

RSpec.describe SalesController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:seller) { create(:user, :seller) }
  let(:user) { create(:user, :user) }
  let(:sale) { create(:sale, user: user) }

  def users
    [admin, seller, user]
  end

  def staff_members
    [seller, admin]
  end

  describe '#index' do

    context "para todo usuario" do
      it 'entrega una respuesta exitosa' do
        users.each do |u|
          request.headers.merge!(auth_header_for(u))
          get :index
          expect(response).to have_http_status(:success)
        end
      end
    end

  end

  describe '#create' do

    context "para todo usuario" do
      it 'entrega una respuesta exitosa' do
        users.each do |u|
          request.headers.merge!(auth_header_for(u))
          expect {
            post :create, params: { sale: { total_price: 100, user_id: user.id } }
          }.to change(Sale, :count).by(1)
        end
      end
    end

    it 'envía un correo al usuario y a los admins al crear una venta' do
      request.headers.merge!(auth_header_for(user))
      post :create, params: { sale: { name: 'Nueva venta', total_price: 100, user_id: user.id } }
      expect(ActiveJob::Base.queue_adapter.enqueued_jobs.count).to eq(User.admin.count + 1)
    end

  end

  describe '#destroy' do

    context "como trabajador" do
      it 'elimina una venta' do
        staff_members.each do |u|
          request.headers.merge!(auth_header_for(u))
          sale = create(:sale, user: u)
          post :destroy, params: {id: sale.id}
          expect(response).to have_http_status(:success)
        end
      end
    end

    context "como cliente" do
      before { request.headers.merge!(auth_header_for(user)) }
      it 'no puede eliminar una venta' do
          post :destroy, params: {id: sale.id}
          expect(response).to have_http_status(:forbidden)
      end
    end

  end

end
