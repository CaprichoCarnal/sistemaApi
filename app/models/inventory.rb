class Inventory < ApplicationRecord
  belongs_to :item, polymorphic: true
end
