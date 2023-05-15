class ElaboratedProduct < ApplicationRecord
  belongs_to :cut
  has_many :elaborated_product_materials
  has_many :supplies, through: :elaborated_product_materials

  accepts_nested_attributes_for :elaborated_product_materials
end
