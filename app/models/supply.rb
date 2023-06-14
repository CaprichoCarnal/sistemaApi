class Supply < ApplicationRecord
  belongs_to :supplier
  has_many :elaborated_product_materials
  has_many :elaborated_products, through: :elaborated_product_materials
  has_many :inventories, as: :item

  after_save :update_inventory
  

  def update_inventory
    inventory = Inventory.find_or_initialize_by(item: self)
    inventory.weight = weight
    inventory.lot = lot
    inventory.category = "Insumo"
   

    inventory.save
  end
end
