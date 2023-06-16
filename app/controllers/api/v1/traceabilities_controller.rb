class Api::V1::TraceabilitiesController < ApplicationController
  def index
    raw_materials = RawMaterial.includes(cuts: :elaborated_products).all
  
    traceability_data = raw_materials.map do |raw_material|
      {
        raw_material_lot: raw_material.lot,
        raw_material_data: {
          born_date: raw_material.born_date,
          weight: raw_material.weight
        },
        cuts: raw_material.cuts.map do |cut|
          {
            cut_lot: cut.lot,
            cut_data: {
              name: cut.name,
              weight: cut.weight
            },
            elaborated_products: cut.elaborated_products.map do |elaborated_product|
              {
                elaborated_product_lot: elaborated_product.lot,
                elaborated_product_data: {
                  name: elaborated_product.name,
                  weight: elaborated_product.weight
                }
              }
            end
          }
        end
      }
    end
  
    render json: traceability_data
  end
  
end
