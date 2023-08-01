class Api::V1::TraceabilitiesController < ApplicationController
  def trazabilidad_hacia_atras
    response_data = []

    # Obtener las materias primas disponibles
    raw_materials = RawMaterial.includes(cuts: :elaborated_products).all

    raw_materials.each do |raw_material|
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
        cuts: []
      }

      raw_material.cuts.each do |cut|
        cut_data = {
          date: cut.created_at,
          raw_material_crotal: raw_material.crotal,
          name: cut.name,
          cut_lot: cut.lot,
          signer: cut.prepared_by,
          type: 'Despiece_Trazabilidad',
          elaborated_products: []
        }
        raw_material_data[:cuts] << cut_data

        cut.elaborated_products.each do |elaborated_product|
          ingredients = "#{cut.name} - #{cut.weight} "
          elaborated_data = {
            date: elaborated_product.created_at,
            name: elaborated_product.name,
            ingredients: ingredients,
            cut_lot: cut.lot,
            elaborated_product_lot: elaborated_product.lot,
            final_weight: elaborated_product.weight,
            type: 'Elaborados_Trazabilidad'
          }
          cut_data[:elaborated_products] << elaborated_data
        end
      end

      response_data << raw_material_data
    end

    render json: response_data, status: :ok
  end

  def trazabilidad_hacia_adelante
    response_data = []
  
    # Obtener las ventas disponibles
    sales = Sale.all
  
    sales.each do |sale|
      sale_data = {
        sale_id: sale.id,
        customer_name: sale.customer&.commercial_name,
        date: sale.date,
        total: sale.total,
        customer: {
          name: sale.customer.commercial_name,
          address: sale.customer.address,
          country: sale.customer.country
        },
        inventory: []
      }
  
      # Obtener los registros de sale_items asociados a la venta actual
      sale_items = sale.sale_items.includes(:inventory)
  
      # Iterar sobre los sale_items y obtener la información de los inventarios asociados
      sale_items.each do |sale_item|
        next unless sale_item.inventory
  
        inventory_item = {
          item_type: sale_item.inventory.item_type,
          item_id: sale_item.inventory.item_id,
          category: sale_item.inventory.category,
          lot: sale_item.inventory.lot,
          weight: sale_item.inventory.weight,
          expiration_date: sale_item.inventory.expiration_date
        }
  
        sale_data[:inventory] << inventory_item
      end
  
      response_data << sale_data
    end
  
    render json: response_data, status: :ok
  end
  

  def trazabilidad_interna
    response_data = []

    # Obtener los cortes disponibles
    cuts = Cut.where(finished: true)

    cuts.each do |cut|
      cut_data = {
        date: cut.created_at,
        name: cut.name,
        cut_lot: cut.lot,
        signer: cut.prepared_by,
        type: 'Corte (Trazabilidad interna)',
        elaborated_products: []
      }

      # Obtener información relacionada con los productos elaborados a partir del corte
      cut.elaborated_products.each do |elaborated_product|
        ingredients = "#{cut.name} - #{cut.weight} "
        elaborated_data = {
          date: elaborated_product.created_at,
          name: elaborated_product.name,
          ingredients: ingredients,
          cut_lot: cut.lot,
          elaborated_product_lot: elaborated_product.lot,
          final_weight: elaborated_product.weight,
          type: 'Producto Elaborado (Trazabilidad interna)'
        }
        cut_data[:elaborated_products] << elaborated_data
      end

      response_data << cut_data
    end

    render json: response_data, status: :ok
  end
end
