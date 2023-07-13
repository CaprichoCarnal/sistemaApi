class RawMaterialPurchase < ApplicationRecord
  belongs_to :supplier
  belongs_to :family, optional: true
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
    elsif family_id == 21
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
        available: 'Disponible para Despiece',
        material_type: 'Canal'
      )
    else
      quantity.times do
        RawMaterial.create!(
          raw_material_purchase: self,
          family: family,
          supplier: supplier,
          description: description ,
          channel_number: '',
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
          available: 'Disponible para Despiece',
          material_type: 'Canal'
        )
      end
    end
  end
end
