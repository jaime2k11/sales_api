# Policies para SalesController
class SalePolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5
  attr_reader :user, :sale

  def initialize(user, sale)
    @user = user
    @sale = sale
  end

  # Solo los trabajadores pueden ver todas las ventas
  def index?
    user.staff?
  end

  # Usuarios pueden ver sus propias ventas, pero no las de otros
  def show?
    user.staff? || sale.user == user
  end

  # Todos pueden crear ventas
  def create?
    true
  end

  # Todos pueden actualizar ventas
  def update?
    true
  end

  # Solo los trabajadores pueden eliminar ventas
  def destroy?
    user.staff?
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
