class ElaboratedProduct < ApplicationRecord
  belongs_to :cut
  has_many :elaborated_product_materials
  has_many :supplies, through: :elaborated_product_materials
  accepts_nested_attributes_for :elaborated_product_materials

  after_save :update_inventory
  has_many :inventories, as: :item

  def update_inventory
    inventory = Inventory.find_or_initialize_by(item: self)
    inventory.category = "Producto Elaborado"  # Categoría para los productos elaborados
    inventory.weight = self.weight
    inventory.lot = self.lot
    inventory.save

    # Actualizar la cantidad utilizada de los suministros
    update_supply_quantities
  end

  private

  def update_supply_quantities
    self.elaborated_product_materials.each do |epm|
      supply = epm.supply
      quantity_used = epm.quantity.to_i

      # Actualizar la cantidad del suministro restando la cantidad utilizada
      new_quantity = supply.quantity - quantity_used
      supply.update(quantity: new_quantity)
    end
  end
end
