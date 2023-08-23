class Return < ApplicationRecord
  belongs_to :invoice
  has_many :return_items, dependent: :destroy
  accepts_nested_attributes_for :return_items

  after_create :update_inventory_and_refund

  private

  def update_inventory_and_refund
    total_refund = 0

    return_items.each do |return_item|
      sale_item = return_item.sale_item
      inventory_item = sale_item.inventory
      inventory_item.update(weight: inventory_item.weight + return_item.quantity_returned)
      sale_item.update(returned: true)
       
      # Sumamos el precio del SaleItem al total de reembolso
      total_refund += sale_item.price * return_item.quantity_returned
    end

    # Restamos el total de reembolso del total del Sale
    sale = invoice.sale
    sale.update(total: sale.total - total_refund)

    # Actualizamos el total de la Invoice restando el total de reembolso
    invoice.update(total: invoice.total - total_refund)
  end
end
