class Cut < ApplicationRecord
  belongs_to :raw_material
  has_many :elaborated_products, dependent: :destroy
  after_save :update_inventory
  after_update :check_availability
  after_create :change_raw_material_availability
  has_many :mix_cuts
  has_many :inventories, as: :item

  def update_inventory
    inventory = Inventory.find_or_initialize_by(item: self)
    inventory.weight = weight
    inventory.lot = lot
    inventory.name = name

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

  def update_available_weight
    if raw_material && raw_material.weight
      cuts_sum_weight = raw_material.cuts.sum(:weight)
      available_weight = raw_material.weight - cuts_sum_weight
      raw_material.update(available_weight: available_weight)
    end
  end
  

  def update_decrease
    if raw_material && raw_material.weight
      total_cuts_weight = raw_material.cuts.sum(:weight)
      decrease = (raw_material.weight - total_cuts_weight).abs
      percentage_decrease = (decrease / raw_material.weight) * 100
      raw_material.update(decrease: percentage_decrease)
    end
  end
  
  

  def change_raw_material_availability
    cuts = Cut.where(raw_material: raw_material) 
    if cuts.any?(&:finished)
      update_raw_material_availability('Despiece Finalizado')
      update_available_weight
      update_decrease
    else
      update_raw_material_availability('Despiece Parcial')
      update_available_weight
    end
  end

  def update_raw_material_availability(availability)
    raw_material.update(available: availability)
  end
end
