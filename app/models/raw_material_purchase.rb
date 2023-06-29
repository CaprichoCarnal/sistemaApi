class RawMaterialPurchase < ApplicationRecord
  belongs_to :supplier
  belongs_to :family
  after_create :create_raw_materials


  def create_raw_materials
    if cut
      RawMaterial.create!(
        raw_material_purchase: self,
        family: family,
        supplier: supplier,
        description: description ,
        born_date: '',
        born_in: '',
        raised_in: '',
        slaughter_date: '',
        slaughtered_in: '',
        crotal: '',
        lot: lot,
        weight: weight ,
        temperature: '',
        classification: '',
        available: 'No',
        material_type: 'Corte'
      )

    else
      quantity.times do
        RawMaterial.create!(
          raw_material_purchase: self,
          family: family,
          supplier: supplier,
          description: description ,
          born_date: '',
          born_in: '',
          raised_in: '',
          slaughter_date: '',
          slaughtered_in: '',
          crotal: '',
          lot: lot,
          weight: '',
          temperature: '',
          classification: '',
          available: 'Si',
          material_type: 'Canal'
        )
      end
    end
  end
end
