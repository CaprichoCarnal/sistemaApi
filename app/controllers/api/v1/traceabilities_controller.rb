class Api::V1::TraceabilitiesController < ApplicationController
  def index
    raw_materials = RawMaterial.includes(cuts: :elaborated_products).where(available: 'No')

    despiece_data = []
    elaborados_data = []

    raw_materials.each do |raw_material|
      raw_material_data = {
        raw_material_lot: raw_material.lot,
        crotal: raw_material.crotal,
        born_date: raw_material.born_date,
        weight: raw_material.weight
      }

      raw_material.cuts.each do |cut|
        despiece = {
          date: cut.created_at,
          raw_material_crotal: raw_material.crotal,
          name: cut.name,
          cut_lot: cut.lot,
          signer: cut.prepared_by
        }
        despiece_data << despiece

        cut.elaborated_products.each do |elaborated_product|
          ingredients = "#{cut.name} - #{cut.weight} "
          elaborados = {
            date: elaborated_product.created_at,
            name: elaborated_product.name,
            ingredients: ingredients,
            cut_lot: cut.lot,
            elaborated_product_lot: elaborated_product.lot,
            final_weight: elaborated_product.weight
          }
          elaborados_data << elaborados
        end
      end
    end

    response_data = {
      Despiece_Trazabilidad: despiece_data,
      Elaborados_Trazabilidad: elaborados_data
    }

    render json: response_data
  end
  
  
  
  
end
