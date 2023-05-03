class Api::V1::RawMaterialsController < ApplicationController
    before_action :set_raw_material, only: [:show, :update, :destroy]

    def index
      raw_materials = RawMaterial.includes(:supplier, :family).all
      render json: raw_materials.to_json(include: { supplier: { only: :commercial_name }, family: { only: [:name, :code] } })
    end

  def show
    render json: @raw_material
  end

  def create
    raw_material = RawMaterial.new(raw_material_params)

    if raw_material.save
      render json: raw_material, status: :created
    else
      render json: raw_material.errors, status: :unprocessable_entity
    end
  end

  def update
    if @raw_material.update(raw_material_params)
      render json: @raw_material
    else
      render json: @raw_material.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @raw_material.destroy
  end

  private

  def set_raw_material
    @raw_material = RawMaterial.find(params[:id])
  end

  def raw_material_params
    params.permit(:raw_material_purchase_id, :family_id, :supplier_id, :born_date, :born_in, :raised_in, :slaughter_date, :slaughtered_in, :crotal, :lot, :weight, :temperature, :classification, :available)
  end
end
