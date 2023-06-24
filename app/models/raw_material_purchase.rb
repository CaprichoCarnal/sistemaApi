class RawMaterialPurchase < ApplicationRecord
  belongs_to :supplier
  belongs_to :family
  after_create :create_raw_materials
  attribute :vat, :integer, default: 10
  attribute :status, :string, default: 'Pendiente'

  def create_raw_materials
    quantity.times do
      RawMaterial.create!(
        raw_material_purchase: self,
        family: family,
        supplier: supplier,
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
        available: 'Si'
      )
    end
  end
end
