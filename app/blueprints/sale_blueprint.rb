# Campos visibles para modelo Sale
class SaleBlueprint < Blueprinter::Base

  identifier :id
  fields :name, :total_price, :created_at, :date_sold
  association :user, blueprint: UserBlueprint

end
