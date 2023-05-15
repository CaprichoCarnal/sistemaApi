class Api::V1::ElaboratedProductsController < ApplicationController
  before_action :set_elaborated_product, only: [:show, :update, :destroy]

  # GET /api/v1/elaborated_products
  def index
    @elaborated_products = ElaboratedProduct.all
    render json: @elaborated_products, include: [:cut, elaborated_product_materials: { include: :supply }]
  end

  # GET /api/v1/elaborated_products/1
  def show
    render json: @elaborated_product, include: [:cut, elaborated_product_materials: { include: :supply }]
  end

  # POST /api/v1/elaborated_products
  def create
    @elaborated_product = ElaboratedProduct.new(elaborated_product_params)
    if @elaborated_product.save
      render json: @elaborated_product, status: :created, location: api_v1_elaborated_product_url(@elaborated_product)
    else
      render json: @elaborated_product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/elaborated_products/1
  def update
    if @elaborated_product.update(elaborated_product_params)
      render json: @elaborated_product
    else
      render json: @elaborated_product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/elaborated_products/1
  def destroy
    @elaborated_product.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_elaborated_product
    @elaborated_product = ElaboratedProduct.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def elaborated_product_params
    params.require(:elaborated_product).permit(:name, :description, :lot, :prepared_by ,:cut_id, elaborated_product_materials_attributes: [:id, :supply_id, :quantity, :_destroy])
  end
end
