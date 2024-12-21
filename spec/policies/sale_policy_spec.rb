require 'rails_helper'

# Pruebas para definicion de Policies de modelo Sale
RSpec.describe SalePolicy, type: :policy do
  let(:admin) { create(:user, :admin) }
  let(:seller) { create(:user, :seller) }
  let(:user) { create(:user, :user) }
  let(:sale) { create(:sale, user: user) }

  subject { described_class }

  def users
    [admin, seller, user]
  end

  def staff_members
    [seller, admin]
  end

  describe '#index?' do
    it 'permite a los trabajadores acceder' do
      staff_members.each do |u|
        policy = subject.new(u, Sale)
        expect(policy.index?).to be true
      end
    end

    it 'niega acceso a usuarios regulares' do
      policy = subject.new(user, Sale)
      expect(policy.index?).to be false
    end
  end

  describe '#show?' do
    it 'permite a los trabajadores ver cualquier venta' do
      staff_members.each do |u|
        policy = subject.new(u, Sale)
        expect(policy.show?).to be true
      end
    end

    it 'permite a un usuario ver su propia venta' do
      policy = subject.new(user, sale)
      expect(policy.show?).to be true
    end

    it 'niega a un usuario ver ventas de otros usuarios' do
      other_user = create(:user, :user)
      other_sale = create(:sale, user: other_user)
      policy = subject.new(user, other_sale)
      expect(policy.show?).to be false
    end
  end

  describe '#create?' do
    it 'permite a todos crear ventas' do
      users.each do |u|
        policy = subject.new(u, Sale)
        expect(policy.create?).to be true
      end
    end
  end

  describe '#destroy?' do
    it 'permite a los trabajadores eliminar ventas' do
      staff_members.each do |u|
        policy = subject.new(u, Sale)
        expect(policy.destroy?).to be true
      end
    end

    it 'niega a los usuarios regulares eliminar ventas' do
      policy = subject.new(user, Sale)
      expect(policy.destroy?).to be false
    end
  end
end
