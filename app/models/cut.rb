class Cut < ApplicationRecord
  belongs_to :raw_material
  has_many :elaborated_products, dependent: :destroy
  after_save :update_inventory
  after_update :check_availability
  after_create :change_raw_material_availability

  has_many :inventories, as: :item

  def update_inventory
    inventory = Inventory.find_or_initialize_by(item: self)
    inventory.weight = weight
    inventory.lot = lot

    if matured && frozen
      inventory.category = "Cortes Madurados y Congelados"
    elsif matured
      inventory.category = "Cortes Madurados"
    elsif frozen
      inventory.category = "Cortes Congelados"
    else
      inventory.category = "Cortes"
    end

    inventory.save
  end

  def check_availability
    if available_for_sale_changed? && !available_for_sale
      remove_from_inventory
      
    end
  end

  def remove_from_inventory
    Inventory.where(item: self).destroy_all
  end

  def change_raw_material_availability
    raw_material.update(available: 'No')
  end
end
