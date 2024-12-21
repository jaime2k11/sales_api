require 'rails_helper'
# Pruebas para definicion de Policies de modelo Product
RSpec.describe ProductPolicy, type: :policy do
  let(:admin) { create(:user, :admin) }
  let(:seller) { create(:user, :seller) }
  let(:user) { create(:user, :user) }
  let(:product) { create(:product) }

  subject { described_class }

  def users
    [admin, seller, user]
  end

  def non_admins
    [seller, user]
  end

  describe '#index?' do
    it 'permite a todos los usuarios acceder' do
      users.each do |u|
        policy = subject.new(u, Product)
        expect(policy.index?).to be true
      end
    end
  end

  describe '#show?' do
    it 'permite a todos los usuarios ver el detalle de un producto' do
      users.each do |u|
        policy = subject.new(u, Product)
        expect(policy.show?).to be true
      end
    end
  end

  describe '#create?' do
    it 'permite al administrador crear productos' do
      policy = subject.new(admin, Product)
      expect(policy.create?).to be true
    end

    it 'niega a vendedores y usuarios crear productos' do
      non_admins.each do |u|
        policy = subject.new(u, Product)
        expect(policy.create?).to be false
      end
    end
  end

  describe '#update?' do
    it 'permite al administrador actualizar productos' do
      policy = subject.new(admin, Product)
      expect(policy.update?).to be true
    end

    it 'niega a vendedores y usuarios actualizar productos' do
      non_admins.each do |u|
        policy = subject.new(u, Product)
        expect(policy.create?).to be false
      end
    end
  end

  describe '#destroy?' do

    it 'permite a los administradores eliminar productos' do
      policy = subject.new(admin, Product)
      expect(policy.destroy?).to be true
    end

    it 'niega a vendedores y usuarios eliminar productos' do
      non_admins.each do |u|
        policy = subject.new(u, Product)
        expect(policy.destroy?).to be false
      end
    end

  end

end
