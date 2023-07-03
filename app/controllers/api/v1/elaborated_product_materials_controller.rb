class Api::V1::ElaboratedProductMaterialsController < ApplicationController
  before_action :set_elaborated_product_material, only: [:show, :update, :destroy]

  # GET /api/v1/elaborated_product_materials
  def index
    @elaborated_product_materials = ElaboratedProductMaterial.all
    render json: @elaborated_product_materials, include: { elaborated_product: {}, supply: { only: [:description, :lot] } }
  end
  

  # GET /api/v1/elaborated_product_materials/1
  def show
    render json: @elaborated_product_material, include: [:elaborated_product, :supply]
  end

  # POST /api/v1/elaborated_product_materials
  def create
    @elaborated_product_material = ElaboratedProductMaterial.new(elaborated_product_material_params)
    if @elaborated_product_material.save
      render json: @elaborated_product_material, status: :created
    else
      render json: @elaborated_product_material.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/elaborated_product_materials/1
  def update
    if @elaborated_product_material.update(elaborated_product_material_params)
      render json: @elaborated_product_material, status: :ok
    else
      render json: @elaborated_product_material.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/elaborated_product_materials/1
  def destroy
    @elaborated_product_material.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_elaborated_product_material
      @elaborated_product_material = ElaboratedProductMaterial.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def elaborated_product_material_params
      params.require(:elaborated_product_material).permit(:elaborated_product_id, :supply_id, :quantity)
    end
end
