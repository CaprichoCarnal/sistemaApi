class Sale < ApplicationRecord
  belongs_to :customer
  has_many :sale_items
  has_one :invoice
  belongs_to :commercial_agent, class_name: 'CommercialAgent', foreign_key: 'commercial_agent_id'
  has_many :inventories, through: :sale_items
  accepts_nested_attributes_for :sale_items
  after_create :update_inventory
  after_create :create_invoice
  after_update :update_invoice_status

  
  private

  def update_inventory
    sale_items.each do |sale_item|
      inventory = sale_item.inventory
      inventory.weight -= sale_item.weight
      inventory.weight = sprintf('%.2f', inventory.weight)  # Formatear el peso antes de guardarlo
      inventory.save
  
      cut = Cut.find_by(name: inventory.name, lot: inventory.lot)
  
      if cut.present?
        cut.weight = inventory.weight
        cut.save
      end
    end
  end
  
  def create_invoice
    invoice = Invoice.create(sale: self, number: generate_albaran_number, date: self.date, total: self.total, albaran_number: generate_albaran_number ,status: self.status,invoiced: false)
    # Aquí puedes agregar cualquier otra lógica relacionada con la creación de la factura
  end

  def update_invoice_status
    self.invoice.update(status: self.status) if self.invoice.present?
  end


  def generate_albaran_number
    last_albaran = Invoice.maximum(:albaran_number)&.split('-')&.last.to_i || 58
    "ALB-%06d" % (last_albaran + 1)
  end

  
end
