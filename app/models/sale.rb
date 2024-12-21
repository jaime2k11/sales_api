class Sale < ApplicationRecord

  # Asociaciones
  belongs_to :user
  has_many :sale_items, dependent: :destroy
  has_many :products, through: :sale_items

  # Validaciones
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  # Asignacion de fecha de venta por defecto, en caso que no se defina manualmente
  before_create -> { self.date_sold = Time.now }

end
