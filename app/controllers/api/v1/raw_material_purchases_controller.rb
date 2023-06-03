class Api::V1::RawMaterialPurchasesController < ApplicationController
  before_action :set_raw_material_purchase, only: [:show, :update, :destroy]

  def index
    @raw_material_purchases = RawMaterialPurchase.includes(:supplier, :family).order(created_at: :asc).all
    render json: @raw_material_purchases.to_json(include: { supplier: { only: :commercial_name }, family: { only: [:name, :code] } })
  end

  def show
    render json: @raw_material_purchase
  end

  def create
    raw_material_purchases = params[:raw_material_purchases] 

    @raw_material_purchases = []

    raw_material_purchases.each do |purchase_params|
      raw_material_purchase = RawMaterialPurchase.new(purchase_params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :family_id, :description, :lot, :quantity, :price, :discount, :total, :vat, :status))
      @raw_material_purchases << raw_material_purchase if raw_material_purchase.save
    end

    if @raw_material_purchases.present?
      render json: @raw_material_purchases, status: :created
    else
      render json: { error: "No se pudieron crear las compras de materia prima" }, status: :unprocessable_entity
    end
  end

  def update
    if @raw_material_purchase.update(raw_material_purchase_params)
      render json: @raw_material_purchase
    else
      render json: @raw_material_purchase.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @raw_material_purchase.destroy
    head :no_content
  end

  private

  def set_raw_material_purchase
    @raw_material_purchase = RawMaterialPurchase.find(params[:id])
  end

  def raw_material_purchase_params
    params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :family_id, :description, :lot, :quantity, :price, :discount, :total, :vat, :status)
  end
end
