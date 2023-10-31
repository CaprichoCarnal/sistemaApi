class ElaboratedProduct < ApplicationRecord
  #attr_accessor :article_data # Agrega un atributo virtual
  belongs_to :cut
  has_many :elaborated_product_materials
  has_many :supplies, through: :elaborated_product_materials
  accepts_nested_attributes_for :elaborated_product_materials

  after_create :update_inventory
  has_many :inventories, as: :item

  def update_inventory
    fecha_actual = Date.today
    dias_a_sumar = 90
    inventory = Inventory.find_or_initialize_by(item: self)
    inventory.category = "Productos Elaborados"  # Categoría para los productos elaborados

    # Formatear el peso antes de asignarlo
    inventory.weight = sprintf('%.2f', self.weight)

    inventory.lot = self.lot
    inventory.name = self.name
    inventory.expiration_date = fecha_actual + dias_a_sumar.days
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
  
      # Actualizar la cantidad del suministro en el inventario
      supply_inventory = supply.inventories.find_or_initialize_by(item: supply)
      supply_inventory.weight = sprintf('%.2f', new_quantity) # Formatear el peso antes de guardar
      supply_inventory.save
      supply_inventory.destroy if new_quantity.zero?
    end
  
    # Restar el peso utilizado del corte y actualizar el inventario del corte
    new_weight_cut = (cut.weight - weight_used).abs
    cut.update(weight: sprintf('%.2f', new_weight_cut)) # Formatear el peso antes de guardar
  
    cut_inventory = cut.inventories.find_or_initialize_by(item: cut)
    cut_inventory.weight = sprintf('%.2f', new_weight_cut) # Formatear el peso antes de guardar
    cut_inventory.save
    cut_inventory.destroy if new_weight_cut.zero?
  end
  
end
