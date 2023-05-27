class ElaboratedProduct < ApplicationRecord
  belongs_to :cut
  has_many :elaborated_product_materials
  has_many :supplies, through: :elaborated_product_materials
  accepts_nested_attributes_for :elaborated_product_materials

  after_save :update_inventory
  has_many :inventories, as: :item

  def update_inventory
    inventory = Inventory.find_or_initialize_by(item: self)
    inventory.category = "Elaborated Products"  # Categoría para los productos elaborados
    inventory.weight = self.weight
    inventory.lot = self.lot
    inventory.save
  end
end
