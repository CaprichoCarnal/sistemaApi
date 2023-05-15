class ElaboratedProductMaterial < ApplicationRecord
  belongs_to :elaborated_product
  belongs_to :supply
end
