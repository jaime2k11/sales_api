require 'rails_helper'

# Validaciones para modelo SaleItem
RSpec.describe SaleItem, type: :model do
  describe 'associations' do
    it { should belong_to(:sale) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:quantity).is_greater_than(0) }
  end
end
