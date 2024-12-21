class SaleItem < ApplicationRecord

  # Asociaciones
  belongs_to :sale
  belongs_to :product

  # Validaciones
  validates :quantity, numericality: { greater_than: 0 }

end
