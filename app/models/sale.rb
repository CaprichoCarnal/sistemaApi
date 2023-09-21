class Sale < ApplicationRecord
  belongs_to :customer
  has_many :sale_items
  belongs_to :commercial_agent, class_name: 'CommercialAgent', foreign_key: 'commercial_agent_id'
  has_many :inventories, through: :sale_items
  accepts_nested_attributes_for :sale_items
  after_save :update_inventory
  after_create :create_invoice
  
  private

  def update_inventory
    sale_items.each do |sale_item|
      if sale_item.returned != true
        inventory = sale_item.inventory
        inventory.weight -= sale_item.weight
        inventory.save
      end
      
    end
  end

  
  def create_invoice
    invoice = Invoice.create(sale: self, number: generate_invoice_number, date: self.date, total: self.total)
    # Aquí puedes agregar cualquier otra lógica relacionada con la creación de la factura
  end

  def generate_invoice_number
    # Lógica para generar el número de factura
    # Puedes adaptarla según tus requerimientos específicos
    "INV-#{self.id}"
  end
end
