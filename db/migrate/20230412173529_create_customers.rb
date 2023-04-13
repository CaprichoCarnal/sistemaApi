class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :fiscal_name
      t.string :commercial_name
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :province
      t.string :country
      t.string :document_type
      t.string :document
      t.string :name
      t.string :phone
      t.string :mobile
      t.string :email
      t.string :bank

      t.timestamps
    end
  end
end
