class RawMaterial < ApplicationRecord
  belongs_to :raw_material_purchase
  belongs_to :family
  belongs_to :supplier
  has_many :cuts
  after_create :create_cut

  def create_cut
    if material_type == 'Corte'
      Cut.create!(
        raw_material: self,
        name: description,
        lot: lot,
        weight: weight,
        matured: false,
        maturity_start_date: nil,
        maturity_end_date: nil,
        frozen: false,
        available_for_sale: true,
        prepared_by: ''
      )
    end
  end

end
