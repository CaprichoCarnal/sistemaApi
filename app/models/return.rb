class Return < ApplicationRecord
  belongs_to :invoice
  has_many :return_items, dependent: :destroy
  accepts_nested_attributes_for :return_items

  after_create :update_inventory

  

  private

  def update_inventory
    return_items.each do |return_item|
      sale_item = return_item.sale_item
      inventory_item = sale_item.inventory
      inventory_item.update(weight: inventory_item.weight + return_item.quantity_returned)
    end
  end
end
