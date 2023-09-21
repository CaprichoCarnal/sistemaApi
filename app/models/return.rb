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
  
      # Actualizamos el peso del SaleItem
      new_weight_sale_item = (sale_item.weight - return_item.quantity_returned).abs
      sale_item.update(weight: new_weight_sale_item)

      
      # Actualizamos el peso del InventoryItem
      new_weight_inventory_item = inventory_item.weight.to_d + return_item.quantity_returned.to_d
      inventory_item.update(weight: new_weight_inventory_item)

     
      
      
  
      sale_item.update(returned: true)
  
      # Sumamos el precio del SaleItem al total de reembolso
      total_refund += sale_item.price * return_item.quantity_returned
    end
  
    # Actualizamos el total de la venta restando el total de reembolso
    sale = invoice.sale
    new_sale_total = (sale.total - total_refund).abs
    sale.update(total: new_sale_total)
  
    # Actualizamos el total de la factura restando el total de reembolso
    new_invoice_total = (invoice.total - total_refund).abs
    invoice.update(total: new_invoice_total)
  end
  
end
