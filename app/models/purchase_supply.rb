class PurchaseSupply < ApplicationRecord
  belongs_to :supplier
  after_create :create_supply_record
  after_update :update_related_invoices

  def update_related_invoices
    related_invoices = PurchaseSupply.where(invoice_code: invoice_code)
                                    .where.not(id: id)

    related_invoices.update_all(
      date_of_purchase: date_of_purchase,
      supplier_id: supplier_id,
      item: item,
      description: description,
      lot: lot,
      quantity: quantity,
      price: price,
      discount: discount,
      total: total,
      vat: vat,
      status: status
    )
  end

  private
  def create_supply_record
    Supply.create!(
      supplier: self.supplier,
      lot: self.lot,
      name: self.item,
      quantity: self.quantity,
      weight: self.weight,
      available_for_sale: true
    )
  end
end
