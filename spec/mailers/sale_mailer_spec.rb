require 'rails_helper'

RSpec.describe SaleMailer, type: :mailer do
  let(:user) { create(:user) }

  describe 'sale_created_user' do

    it 'envía el correo al usuario correcto con el asunto esperado' do
      sale = create(:sale, user: user)
      mail = SaleMailer.sale_created_user(sale)

      expect(mail.to).to eq([user.email])
      expect(mail.subject).to eq('Tu venta fue creada exitosamente')
    end
  end

  describe 'sale_created_admin' do
    let(:admin) { create(:user, :admin) }
    let(:sale) { create(:sale, user: user) }

    it 'envía el correo al administrador correcto con el asunto esperado' do
      mail = SaleMailer.sale_created_admin(sale, admin)

      expect(mail.to).to eq([admin.email])
      expect(mail.subject).to eq('Se ha creado una nueva venta')
    end
  end


end
