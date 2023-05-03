class Api::V1::RawMaterialPurchasesController < ApplicationController
    before_action :set_raw_material_purchase, only: [:show, :update, :destroy]

    def index
      @raw_material_purchases = RawMaterialPurchase.includes(:supplier, :family).all
      render json: @raw_material_purchases.to_json(include: { supplier: { only: :commercial_name }, family: { only: [:name, :code] } })
    end
  
    def show
      render json: @raw_material_purchase
    end
  
    def create
      @raw_material_purchase = RawMaterialPurchase.new(raw_material_purchase_params)
  
      if @raw_material_purchase.save
        #@raw_material_purchase.create_raw_materials
        render json: @raw_material_purchase, status: :created
      else
        render json: @raw_material_purchase.errors, status: :unprocessable_entity
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
      params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :family_id, :description, :lot ,:quantity, :price, :discount, :total, :vat, :status)
    end
end
