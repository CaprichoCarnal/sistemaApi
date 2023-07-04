class Api::V1::PurchaseSuppliesController < ApplicationController
    before_action :set_purchase_supply, only: [:show, :update, :destroy]

    def index
      @purchase_supplies = PurchaseSupply.includes(:supplier).order(created_at: :desc).all
      render json: @purchase_supplies.to_json(include: { supplier: { only: :commercial_name } })
    end

    def show
      render json: @purchase_supply
    end

    def create
      purchase_supplies = params[:purchase_supplies]
      @purchase_supplies = []

      purchase_supplies.each do |purchase_params|
        purchase_supply = PurchaseSupply.new(purchase_params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :description, :lot, :quantity, :price, :discount, :total, :vat, :status,:weight,:raw_material))

        if purchase_supply.save
          @purchase_supplies << purchase_supply

          if purchase_supply.raw_material
            create_raw_material_purchase(purchase_supply)  # Crear registro en RawMaterialPurchase
          end
        end
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
      params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :description, :lot, :quantity, :price, :discount, :total, :vat, :status,:weight,:raw_material)
    end

    def create_raw_material_purchase(purchase_supply)
      RawMaterialPurchase.create!(
        date_of_purchase: purchase_supply.date_of_purchase,
        supplier_id: purchase_supply.supplier_id,
        invoice_code: purchase_supply.invoice_code,
        item: purchase_supply.item,
        family_id: 21,
        description: purchase_supply.description,
        lot: purchase_supply.lot,
        quantity: purchase_supply.quantity,
        price: purchase_supply.price,
        discount: purchase_supply.discount,
        total: purchase_supply.total,
        vat: purchase_supply.vat,
        status: purchase_supply.status,
        weight: purchase_supply.weight,
        cut: false
      )
    end

end
