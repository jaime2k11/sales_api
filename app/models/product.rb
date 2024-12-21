class Product < ApplicationRecord

  # Validaciones
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  # Asociaciones
  has_many :sale_items, dependent: :destroy
  has_many :sales, through: :sale_items

end
