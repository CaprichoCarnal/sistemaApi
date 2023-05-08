class PurchaseSupply < ApplicationRecord
  belongs_to :supplier
  after_create :create_supply_record

  private
  def create_supply_record
    Supply.create!(
      supplier: self.supplier,
      lot: self.lot,
      name: self.description,
      quantity: self.quantity,
      weight: 0.0
    )
  end
end
