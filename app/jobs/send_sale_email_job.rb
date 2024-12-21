class SendSaleEmailJob < ApplicationJob
  queue_as :default

  def perform(sale)
    # Enviar correo al usuario
    SaleMailer.sale_created_user(sale).deliver_later
    # Enviar correo a todos los admins
    User.admin.each do |admin|
      SaleMailer.sale_created_admin(sale, admin).deliver_later
    end
  end
end
