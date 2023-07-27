class CreateCommercialAgents < ActiveRecord::Migration[7.0]
  def change
    create_table :commercial_agents do |t|
      t.string :code
      t.string :name
      t.string :nif
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
