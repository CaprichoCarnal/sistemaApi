class ReturnItem < ApplicationRecord
  belongs_to :return
  belongs_to :sale_item
end
