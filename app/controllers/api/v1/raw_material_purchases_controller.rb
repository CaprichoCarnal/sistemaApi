class Api::V1::RawMaterialPurchasesController < ApplicationController
  before_action :set_raw_material_purchase, only: [:show, :update, :destroy]

  def index
    # Agrupar las compras de materia prima por factura
    raw_material_purchases_grouped = RawMaterialPurchase.includes(:supplier, :family)
                                                       .order(created_at: :desc)
                                                       .group_by(&:invoice_code)
    
    # Crear una estructura para almacenar los resultados
    result = []
    
    # Recorrer cada grupo de compras por factura
    raw_material_purchases_grouped.each do |invoice_code, purchases|
      # Obtener el estado (status) de la primera compra en el grupo
      status = purchases.first.status
      
      # Crear una estructura para almacenar la información de cada compra
      purchases_info = purchases.map do |purchase|
        {
        
          family: {
            name: purchase.family.name,
            code: purchase.family.code
          },
          description: purchase.description,
          lot: purchase.lot,
          quantity: purchase.quantity,
          price: purchase.price,
          discount: purchase.discount,
          total: purchase.total,
          vat: purchase.vat,
          weight: purchase.weight,
          cut: purchase.cut,
          payment: purchase.payment,
          supplier: {
            fiscal_name: purchase.supplier.fiscal_name
          }
        }
      end
      
      # Agregar la información de la factura al resultado
      result << {
          invoice_code: invoice_code,
          supplier: purchases.first.supplier.fiscal_name,
          family: purchases.first.family.name,
          familyCode: purchases.first.family.code,
          date_of_purchase: purchases.first.date_of_purchase,
          total: purchases.first.total, 
          vat: purchases.first.vat, 
          payment: purchases.first.payment, 
          status: status,
          purchases: purchases_info,
        }
    end
    
    # Renderizar como respuesta JSON
    render json: result.to_json
  end
  

  def show
    render json: @raw_material_purchase
  end

  def create
    raw_material_purchases = params[:raw_material_purchases]

    @raw_material_purchases = []

    raw_material_purchases.each do |purchase_params|
      raw_material_purchase = RawMaterialPurchase.new(purchase_params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :family_id, :description, :lot, :quantity, :price, :discount, :total, :vat, :status,:weight,:cut,:payment))
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
    params.permit(:date_of_purchase, :supplier_id, :invoice_code, :item, :family_id, :description, :lot, :quantity, :price, :discount, :total, :vat ,:status, :weight,:cut,:payment)
  end
end
