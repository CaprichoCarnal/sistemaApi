class Inventory < ApplicationRecord
  belongs_to :item, polymorphic: true, optional: true
  validates :category, presence: true


  
end
