class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]

  # Listado de productos
  # Se muestra listado utilizando el Blueprint respectivo
  def index
    @products = Product.page(params[:page]).order(:name)
    render json: ProductBlueprint.render(@products)
  end

  # Despliegue de producto especifico, utilizando su Blueprint
  def show
    render json: ProductBlueprint.render(@product)
  end

  # Creacion de nuevo producto
  def create
    @product = Product.new(product_params)
    authorize @product
    if @product.save
      render json: ProductBlueprint.render(@product), status: :created
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end


  # Actualizacion de producto
  def update
    authorize @product
    if @product.update(product_params)
      render json: ProductBlueprint.render(@product), status: :ok
    else
      render json: { errors: @product.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Eliminacion de producto
  def destroy
    authorize @product
    @product.destroy
    head :no_content
  end

  private

  # Obtencion de producto para las acciones correspondientes
  def set_product
    @product = Product.find(params[:id])
  end

  # Parametros validos para administracion de productos
  def product_params
    params.require(:product).permit(:name, :description, :price, :stock)
  end

end
