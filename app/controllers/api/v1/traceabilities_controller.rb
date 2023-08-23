class Api::V1::TraceabilitiesController < ApplicationController
  def all_trazabilities
    response_data = {
      trazabilidad_hacia_atras: trazabilidad_hacia_atras,
      trazabilidad_hacia_adelante: trazabilidad_hacia_adelante,
      trazabilidad_interna: trazabilidad_interna
    }
    
    #render json: response_data, status: :ok
  end

  def trazabilidad_hacia_atras
    response_data = []
  
    # Obtener las materias primas disponibles
    raw_materials = RawMaterial.includes(cuts: [:elaborated_products, :mix_cuts]).all
  
    raw_materials.each do |raw_material|
      raw_material_data = {
        raw_material_lot: raw_material.lot,
        crotal: raw_material.crotal,
        born_date: raw_material.born_date,
        weight: raw_material.weight,
        created_at: raw_material.created_at,
        supplier: {
          name: raw_material.supplier.fiscal_name,
          address: raw_material.supplier.address,
          country: raw_material.supplier.country
        },
        cuts: []
      }
  
      raw_material.cuts.each do |cut|
        cut_data = {
          cut_name: cut.name,
          cut_lot: cut.lot,
          signer: cut.prepared_by,
          created_at: cut.created_at,
          cut_type: 'Despiece_Trazabilidad',
          elaborated_products: [],
          mix_cuts: []
        }
  
        cut.elaborated_products.each do |elaborated_product|
          elaborated_product_data = {
            elaborated_product_date: elaborated_product.created_at,
            elaborated_product_name: elaborated_product.name,
            elaborated_product_ingredients: "#{cut.name} - #{cut.weight}",
            elaborated_product_cut_lot: cut.lot,
            elaborated_product_lot: elaborated_product.lot,
            elaborated_product_final_weight: elaborated_product.weight,
            elaborated_created_at: elaborated_product.created_at,
            elaborated_product_type: 'Elaborados_Trazabilidad'
          }
  
          cut_data[:elaborated_products] << elaborated_product_data
        end
  
        cut.mix_cuts.each do |mix_cut|
          mix_cut_data = {
            mix_cut_name: mix_cut.name,
            mix_cut_lot: mix_cut.lot,
            mix_cut_weight: mix_cut.weight,
            mix_cut_frozen: mix_cut.frozen,
            mix_cut_expiration_date: mix_cut.expiration_date,
            mix_cut_created_at: mix_cut.created_at
          }
  
          cut_data[:mix_cuts] << mix_cut_data
        end
  
        raw_material_data[:cuts] << cut_data
      end
  
      response_data << raw_material_data
    end
    #return response_data
    render json: response_data, status: :ok
  end
  
  
  
  

  def trazabilidad_hacia_adelante
    response_data = []
  
    # Obtener las ventas disponibles
    sales = Sale.all
  
    sales.each do |sale|
      # Obtener los registros de sale_items asociados a la venta actual
      sale_items = sale.sale_items.includes(:inventory)
  
      # Iterar sobre los sale_items y obtener la información de los inventarios asociados
      inventory_items = sale_items.map do |sale_item|
        next unless sale_item.inventory
  
        {
          "item_type": sale_item.inventory.item_type,
          "item_id": sale_item.inventory.item_id,
          "category": sale_item.inventory.category,
          "lot": sale_item.inventory.lot,
          "weight": sale_item.inventory.weight,
          "expiration_date": sale_item.inventory.expiration_date
        }
      end.compact  # Eliminamos los elementos nulos
  
      sale_data = {
        "inventory": inventory_items,
        "sale": {
          "sale_id": sale.id,
          "customer_name": sale.customer&.commercial_name,
          "date": sale.date,
          "total": sale.total,
          "customer": {
            "name": sale.customer.commercial_name,
            "address": sale.customer.address,
            "country": sale.customer.country
          }
        }
      }
  
      response_data << sale_data
    end
  
    render json: response_data, status: :ok
  end
  


  
  
  

  def trazabilidad_interna
    response_data = []
  
    # Obtener los cuts disponibles
    cuts = Cut.includes(:elaborated_products, :mix_cuts).all
  
    cuts.each do |cut|
      cut_data = {
        date: cut.created_at,
        name: cut.name,
        cut_lot: cut.lot,
        signer: cut.prepared_by,
        type: 'Corte (Trazabilidad interna)',
        elaborated_products: [],
        mix_cuts: []
      }
  
      cut.elaborated_products.each do |elaborated_product|
        elaborated_data = {
          date: elaborated_product.created_at,
          name: elaborated_product.name,
          elaborated_product_lot: elaborated_product.lot,
          final_weight: elaborated_product.weight,
          elaborated_created_at: elaborated_product.created_at,
          type: 'Producto Elaborado (Trazabilidad interna)'
        }
  
        cut_data[:elaborated_products] << elaborated_data
      end
  
      cut.mix_cuts.each do |mix_cut|
        mix_cut_data = {
          date: mix_cut.created_at,
          name: mix_cut.name,
          mix_cut_lot: mix_cut.lot,
          frozen: mix_cut.frozen,
          expiration_date: mix_cut.expiration_date,
          mix_cut_created_at: mix_cut.created_at,
          type: 'Mix Cut (Trazabilidad interna)'
        }
  
        cut_data[:mix_cuts] << mix_cut_data
      end
  
      response_data << cut_data
    end
    #return response_data
    render json: response_data , status: :ok
  end
  
  
  
  
  
  
  
end
