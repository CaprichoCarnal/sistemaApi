class AddFieldsToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :albaran_number, :string
    add_column :invoices, :invoiced, :boolean
  end
end
