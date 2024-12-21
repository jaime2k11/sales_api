FactoryBot.define do
  factory :sale_item do
    sale { nil }
    product { nil }
    quantity { 1 }
  end
end
