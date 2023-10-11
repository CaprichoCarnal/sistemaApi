class Invoice < ApplicationRecord
  belongs_to :sale
  attribute :status, :string, default: 'Pendiente'
  attribute :invoiced, :boolean, default: false
  after_update :update_number, if: :invoiced_changed?

  before_save :update_number, if: :invoiced_changed?

 


  def update_number
    self.number = generate_invoice_number if self.invoiced
  end


  def generate_invoice_number
    last_invoice = Invoice.where("number LIKE ?", "INV-%").pluck(:number).map { |n| n.split('-').last.to_i }.max || 1741
    "INV-%07d" % (last_invoice + 1)
  end



  
end
