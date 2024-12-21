class SalesController < ApplicationController
  before_action :set_sale, only: %i[show update destroy]

  # Listado de ventas, filtradas segun usuario actual
  # Se muestra listado utilizando el Blueprint respectivo
  def index
    @sales = policy_scope(Sale).includes(:user, :products).page(params[:page]).order('date_sold desc') # Filtra según las Policies
    render json: SaleBlueprint.render(@sales)
  end


  # Despliegue de venta
  def show
    authorize @sale
    render json: SaleBlueprint.render(@sale)
  end

  # Creacion de una nueva venta
  # AUnque no es necesario el autorizar, se deja la revisión si las condiciones cambian a futuro
  def create
    @sale = Sale.new(sale_params)
    authorize @sale
    if @sale.save
      SendSaleEmailJob.perform_later(@sale)
      render json: @sale, status: :created
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # Actualizacion de una venta
  def update
    authorize @sale
    if @sale.update(sale_params)
      render json: @sale
    else
      render json: @sale.errors, status: :unprocessable_entity
    end
  end

  # Eliminacion de una venta
  def destroy
    authorize @sale
    @sale.destroy
    head :no_content
  end

  private

  # Obtencion de venta para las acciones correspondientes
  def set_sale
    @sale = Sale.find(params[:id])
  end

  # Parametros validos para administracion de ventas
  def sale_params
    params.require(:sale).permit(:total_price, :user_id)
  end

end
