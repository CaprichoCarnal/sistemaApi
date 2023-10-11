class Api::V1::PurchaseSuppliesController < ApplicationController
    before_action :set_purchase_supply, only: [:show, :update, :destroy]

    def index
      # Agrupar las compras de suministros por factura
      purchase_supplies_grouped = PurchaseSupply.includes(:supplier)
                                                .order(created_at: :desc)
                                                .group_by(&:invoice_code)
      
      # Crear una estructura para almacenar los resultados
      result = []
      
      # Recorrer cada grupo de compras por factura
      purchase_supplies_grouped.each do |invoice_code, supplies|
        # Obtener el estado (status) de la primera compra en el grupo
        status = supplies.first.status
        
        # Crear una estructura para almacenar la información de cada compra
        supplies_info = supplies.map do |supply|
          {
            description: supply.description,
            name: supply.item,
            quantity: supply.quantity,
            price: supply.price,
            discount: supply.discount,
            total: supply.total,
            vat: supply.vat,
            payment: supply.payment,
            supplier: {
              fiscal_name: supply.supplier.fiscal_name
            }
          }
        end
        
        # Agregar la información de la factura al resultado
        result << {
        id: supplies.first.id,  
        invoice_code: invoice_code,
        supplier: supplies.first.supplier.fiscal_name,
        supplier_id: supplies.first.supplier.id,  
        date_of_purchase: supplies.first.date_of_purchase,
        total: supplies.first.total,
        vat: supplies.first.vat,  
        payment: supplies.first.payment,  
        status: status,
        purchases: supplies_info
      }
      end
      
      # Renderizar como respuesta JSON
      render json: result.to_json
    end
    

    def show
      render json: @purchase_supply
    end

    def create
      purchase_supplies = params[:purchase_supplies]
      @purchase_supplies = []

      purchase_supplies.each do |purchase_params|
        purchase_supply = PurchaseSupply.new(purchase_params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :description, :lot, :quantity, :price, :discount, :total, :vat, :status,:weight,:raw_material,:payment))

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
      params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :description, :lot, :quantity, :price, :discount, :total, :vat, :status,:weight,:raw_material,:payment)
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
