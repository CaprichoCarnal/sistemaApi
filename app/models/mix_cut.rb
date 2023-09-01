class MixCut < ApplicationRecord
  belongs_to :cut
  has_many :mixed_cut
  accepts_nested_attributes_for :mixed_cut

  after_save :update_inventory
  has_many :inventories, as: :item

  def update_inventory
    inventory = Inventory.find_or_initialize_by(item: self)
    inventory.category = "Productos Elaborados"  # Categoría para los productos elaborados
    inventory.weight = self.weight
    inventory.lot = self.lot
    inventory.name = self.name
    inventory.save

    # Actualizar la cantidad utilizada de los suministros
    update_supply_quantities
  end

  private

  def update_supply_quantities
    self.mixed_cut.each do |epm|
      supply = epm.cut
      quantity_used = epm.weight.to_i

      # Actualizar la cantidad del suministro restando la cantidad utilizada
      new_quantity = cut.weight - quantity_used
      cut.update(weight: new_quantity)

       # Actualizar la cantidad del suministro en el inventario
       supply_inventory = cut.inventories.find_or_initialize_by(item: cut)
       supply_inventory.weight = new_quantity
       supply_inventory.save
       supply_inventory.destroy if new_quantity.zero?
    end

end
end