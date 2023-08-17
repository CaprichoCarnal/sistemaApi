class Api::V1::TraceabilitiesController < ApplicationController
  def trazabilidad_hacia_atras
    response_data = []
  
    # Obtener las materias primas disponibles
    raw_materials = RawMaterial.includes(cuts: :elaborated_products).all
  
    raw_materials.each do |raw_material|
      raw_material.cuts.each do |cut|
        cut.elaborated_products.each do |elaborated_product|
          raw_material_data = {
            raw_material_lot: raw_material.lot,
            crotal: raw_material.crotal,
            born_date: raw_material.born_date,
            weight: raw_material.weight,
            supplier: {
              name: raw_material.supplier.fiscal_name,
              address: raw_material.supplier.address,
              country: raw_material.supplier.country
            },
            date: cut.created_at,
            raw_material_crotal: raw_material.crotal,
            cut_name: cut.name,
            cut_lot: cut.lot,
            signer: cut.prepared_by,
            cut_type: 'Despiece_Trazabilidad',
            elaborated_product_date: elaborated_product.created_at,
            elaborated_product_name: elaborated_product.name,
            elaborated_product_ingredients: "#{cut.name} - #{cut.weight}",
            elaborated_product_cut_lot: cut.lot,
            elaborated_product_lot: elaborated_product.lot,
            elaborated_product_final_weight: elaborated_product.weight,
            elaborated_product_type: 'Elaborados_Trazabilidad'
          }
  
          response_data << raw_material_data
        end
      end
    end
  
    render json: response_data, status: :ok
  end
  
  

  def trazabilidad_hacia_adelante
    response_data = []
  
    # Obtener las ventas disponibles
    sales = Sale.all
  
    sales.each do |sale|
      # Obtener los registros de sale_items asociados a la venta actual
      sale_items = sale.sale_items.includes(:inventory)
  
      sale_items.each do |sale_item|
        next unless sale_item.inventory
  
        inventory_item = {
          item_type: sale_item.inventory.item_type,
          item_id: sale_item.inventory.item_id,
          category: sale_item.inventory.category,
          lot: sale_item.inventory.lot,
          weight: sale_item.inventory.weight,
          expiration_date: sale_item.inventory.expiration_date,
          sale_id: sale.id,
          customer_name: sale.customer&.commercial_name,
          date: sale.date,
          total: sale.total,
          customer: {
            name: sale.customer.commercial_name,
            address: sale.customer.address,
            country: sale.customer.country
          }
        }
  
        response_data << inventory_item
      end
    end
  
    render json: response_data, status: :ok
  end
  
  
  

  def trazabilidad_interna
    response_data = []
    
    # Obtener los cuts disponibles
    cuts = Cut.all
    
    cuts.each do |cut|
      cut_data = {
        date: cut.created_at,
        name: cut.name,
        cut_lot: cut.lot,
        signer: cut.prepared_by,
        type: 'Corte (Trazabilidad interna)'
      }
    
      response_data << cut_data
    
      cut.elaborated_products.each do |elaborated_product|
        elaborated_data = {
          date: elaborated_product.created_at,
          name: elaborated_product.name,
          elaborated_product_lot: elaborated_product.lot,
          final_weight: elaborated_product.weight,
          type: 'Producto Elaborado (Trazabilidad interna)',
          associated_cut: {
            date: cut.created_at,
            name: cut.name,
            cut_lot: cut.lot,
            signer: cut.prepared_by,
            type: 'Corte (Trazabilidad interna)'
          }
        }
    
        response_data << elaborated_data
      end
    end
    
    MixCut.all.each do |mix_cut|
      mix_cut_data = {
        date: mix_cut.created_at,
        name: mix_cut.name,
        mix_cut_lot: mix_cut.lot,
        frozen: mix_cut.frozen,
        expiration_date: mix_cut.expiration_date,
        type: 'Mix Cut (Trazabilidad interna)',
        associated_cut: nil
      }
    
      response_data << mix_cut_data
    end
    
    render json: response_data, status: :ok
  end
  
  
  
  
  
  
end
