class Api::V1::PurchaseSuppliesController < ApplicationController
    before_action :set_purchase_supply, only: [:show, :update, :destroy]

    def index
      @purchase_supplies = PurchaseSupply.includes(:supplier).all
      render json: @purchase_supplies.to_json(include: { supplier: { only: :commercial_name } })
    end
    
    def show
      render json: @purchase_supply
    end
    
    def create
      purchase_supplies = params[:purchase_supplies] 
    
      @purchase_supplies = []
    
      purchase_supplies.each do |purchase_params|
        purchase_supply = PurchaseSupply.new(purchase_params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :description, :lot, :quantity, :price, :discount, :total, :vat, :status))
        @purchase_supplies << purchase_supply if purchase_supply.save
      end
    
      if @purchase_supplies.present?
        render json: @purchase_supplies, status: :created
      else
        render json: { error: "No se pudieron crear las compras de suministros" }, status: :unprocessable_entity
      end
    end
    
    def update
      if @purchase_supply.update(purchase_supply_params)
        render json: @purchase_supply
      else
        render json: @purchase_supply.errors, status: :unprocessable_entity
      end
    end
    
    def destroy
      @purchase_supply.destroy
      head :no_content
    end
    
    private
    
    def set_purchase_supply
      @purchase_supply = PurchaseSupply.find(params[:id])
    end
    
    def purchase_supply_params
      params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :description, :lot, :quantity, :price, :discount, :total, :vat, :status)
    end
    
end
