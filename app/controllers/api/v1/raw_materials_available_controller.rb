class Api::V1::RawMaterialsAvailableController < ApplicationController
  def index
    @raw_materials = RawMaterial.includes(:supplier, :family).where(available: 'Si')
    render json: @raw_materials.to_json(include: { supplier: { only: :fiscal_name }, family: { only: [:name, :code] } })
  end
    
    def update
        @raw_material = RawMaterial.find(params[:id])
        if @raw_material.update(raw_material_params)
          render json: @raw_material
        else
          render json: @raw_material.errors, status: :unprocessable_entity
        end
    end
    
    private
    
    def raw_material_params
        params.permit(:available)
    end
end
