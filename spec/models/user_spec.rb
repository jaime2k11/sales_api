require 'rails_helper'

# Validaciones para modelo User
RSpec.describe User, type: :model do

  let(:admin) { create(:user, :admin) }
  let(:seller) { create(:user, :admin) }
  let(:user) { create(:user, :user) }

  subject { build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:role) }
    it { should define_enum_for(:role).with_values(%w[user seller admin]) }
  end

  describe '#staff?' do
    it 'returns true for staff users' do
      expect(admin.staff?).to be true
      expect(seller.staff?).to be true
    end

    it 'returns false for regular users' do
      expect(user.staff?).to be false
    end
  end
end
