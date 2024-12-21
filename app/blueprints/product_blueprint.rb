# Campos visibles para modelo Product
class ProductBlueprint < Blueprinter::Base

  identifier :id
  fields :name, :description, :price, :stock

end
