class Api::V1::TraceabilitiesController < ApplicationController
  def trazabilidad_hacia_adelante
    response_data = []

    # Obtener las materias primas disponibles
    raw_materials = RawMaterial.includes(cuts: :elaborated_products).where(available: 'No')

    raw_materials.each do |raw_material|
      raw_material_data = {
        raw_material_lot: raw_material.lot,
        crotal: raw_material.crotal,
        born_date: raw_material.born_date,
        weight: raw_material.weight,
        type: 'Trazabilidad hacia adelante'
      }

      # Obtener datos adicionales del proveedor (supplier)
      supplier = Supplier.find(raw_material.supplier_id)
      raw_material_data[:supplier_name] = supplier.fiscal_name
      raw_material_data[:supplier_address] = supplier.address
      raw_material_data[:supplier_country] = supplier.country

      response_data << raw_material_data

      raw_material.cuts.each do |cut|
        cut_data = {
          date: cut.created_at,
          raw_material_crotal: raw_material.crotal,
          name: cut.name,
          cut_lot: cut.lot,
          signer: cut.prepared_by,
          type: 'Despiece_Trazabilidad'
        }
        response_data << cut_data

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
          response_data << elaborated_data
        end
      end
    end

    render json: response_data, status: :ok
  end

  def trazabilidad_hacia_atras
    response_data = []

    # Obtener las ventas disponibles
    sales = Sale.all

    sales.each do |sale|
      sale_data = {
        sale_id: sale.id,
        customer_name: sale.customer&.commercial_name,
        date: sale.date,
        total: sale.total,
        type: 'Trazabilidad hacia atrás'
      }

      # Obtener datos adicionales del cliente (customer)
      customer = Customer.find(sale.customer_id)
      sale_data[:customer_address] = customer.address
      sale_data[:customer_country] = customer.country

      response_data << sale_data

      # Obtener información relacionada con la venta, como la materia prima y el lote
      inventory_item = sale.sale_items.first&.inventory

      if inventory_item&.item_type == 'RawMaterial'
        raw_material = inventory_item.raw_material
        lot = inventory_item.lot

        raw_material_data = {
          raw_material_lot: raw_material&.lot,
          crotal: raw_material&.crotal,
          born_date: raw_material&.born_date,
          weight: raw_material&.weight,
          type: 'Materia Prima (Trazabilidad hacia atrás)'
        }

        # Obtener datos adicionales del proveedor (supplier)
        supplier = Supplier.find(raw_material&.supplier_id)
        raw_material_data[:supplier_name] = supplier.fiscal_name
        raw_material_data[:supplier_address] = supplier.address
        raw_material_data[:supplier_country] = supplier.country

        response_data << raw_material_data

        # Obtener información relacionada con los cortes elaborados a partir de la materia prima
        raw_material&.cuts&.each do |cut|
          cut_data = {
            date: cut.created_at,
            raw_material_crotal: raw_material.crotal,
            name: cut.name,
            cut_lot: cut.lot,
            signer: cut.prepared_by,
            type: 'Corte (Trazabilidad hacia atrás)'
          }
          response_data << cut_data

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
              type: 'Producto Elaborado (Trazabilidad hacia atrás)'
            }
            response_data << elaborated_data
          end
        end
      end
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
        type: 'Corte (Trazabilidad interna)'
      }
      response_data << cut_data

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
        response_data << elaborated_data
      end
    end

    render json: response_data, status: :ok
  end
end
