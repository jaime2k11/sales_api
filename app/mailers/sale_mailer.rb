class SaleMailer < ApplicationMailer
  default from: 'notifications@example.com'

  # Envío de email al usuario que creó la venta
  def sale_created_user(sale)
    @sale = sale
    mail(to: @sale.user.email, subject: 'Tu venta fue creada exitosamente')
  end

  # Envío de email a los administradores, cuando una venta es creada
  def sale_created_admin(sale, admin)
    @sale = sale
    @admin = admin
    mail(to: @admin.email, subject: 'Se ha creado una nueva venta')
  end
end
