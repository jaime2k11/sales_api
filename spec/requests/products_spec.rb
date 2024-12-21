# Pruebas para controller Products
RSpec.describe ProductsController, type: :controller do
  let(:admin) { create(:user, :admin) }
  let(:seller) { create(:user, :admin) }
  let(:user) { create(:user, :user) }
  let(:product) { create(:product) }

  def non_admins
    [seller, user]
  end

  describe '#index' do
    it 'entrega el listado de productos' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#create' do
    context 'como admin' do
      before { request.headers.merge!(auth_header_for(admin)) }
      it 'crea un nuevo producto' do
        post :create, params: { product: { name: 'New Product', price: 10.0, stock: 100 } }
        expect(response).to have_http_status(:created)
      end
    end

    context 'como no admin' do
      before { request.headers.merge!(auth_header_for(user)) }
      it 'niega acceso si usuario no es administrador' do
        non_admins.each do |u|
          post :create, params: { product: { name: 'New Product', price: 10.0, stock: 100 } }
          expect(response).to have_http_status(:forbidden)
        end
      end
    end

  end
end
