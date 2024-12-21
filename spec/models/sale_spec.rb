require 'rails_helper'

# Validaciones para modelo Sale
RSpec.describe Sale, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }
  end
end
