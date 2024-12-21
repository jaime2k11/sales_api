# Policies para ProductController
class ProductPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  # Todos pueden listar productos
  def index?
    true
  end

  # Todos pueden desplegar detalle de productos
  def show?
    true
  end

  # Solo administradores pueden crear productos
  def create?
    user.admin?
  end

  # Solo administradores pueden actualizar productos
  def update?
    user.admin?
  end

  # Solo los admins pueden eliminar productos
  def destroy?
    user.admin?
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
