class Supply < ApplicationRecord
  belongs_to :supplier
  has_many :elaborated_product_materials
  has_many :elaborated_products, through: :elaborated_product_materials
end
