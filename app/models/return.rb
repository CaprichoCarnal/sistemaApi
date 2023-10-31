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
  
      # Obtener el Cut asociado al nombre y lote
      cut = Cut.find_by(name: inventory_item.name, lot: inventory_item.lot)
  
      # Actualizamos el peso del SaleItem
      new_weight_sale_item = (sale_item.weight - return_item.quantity_returned).abs
      sale_item.update(weight: sprintf('%.2f', new_weight_sale_item)) # Formatear el peso antes de guardar
  
      # Actualizamos el peso del InventoryItem
      new_weight_inventory_item = (inventory_item.weight.to_d + return_item.quantity_returned.to_d).abs
      inventory_item.update(weight: sprintf('%.2f', new_weight_inventory_item)) # Formatear el peso antes de guardar
  
      if cut.present?
        # Restar el peso del Cut
        new_weight_cut = (cut.weight - return_item.quantity_returned).abs
        cut.update(weight: sprintf('%.2f', new_weight_cut)) # Formatear el peso antes de guardar
      end
  
      sale_item.update(returned: true)
  
      # Sumamos el precio del SaleItem al total de reembolso
      total_refund += sale_item.price * return_item.quantity_returned
    end
  
    # Actualizamos el total de la venta restando el total de reembolso
    sale = invoice.sale
    new_sale_total = (sale.total - total_refund).abs
    sale.update(total: sprintf('%.2f', new_sale_total)) # Formatear el total antes de guardar
  
    # Actualizamos el total de la factura restando el total de reembolso
    new_invoice_total = (invoice.total - total_refund).abs
    invoice.update(total: sprintf('%.2f', new_invoice_total)) # Formatear el total antes de guardar
  
    # Cambiamos el estado de la factura a "Devolución"
    invoice.update(status: "Devolución")
  end
  
  
end
