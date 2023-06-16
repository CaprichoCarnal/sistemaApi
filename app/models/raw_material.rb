class RawMaterial < ApplicationRecord
  belongs_to :raw_material_purchase
  belongs_to :family
  belongs_to :supplier
  has_many :cuts
end
