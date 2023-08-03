class AddCommercialAgentToSales < ActiveRecord::Migration[7.0]
  def change
    add_reference :sales, :commercial_agent, null: false, foreign_key: true
  end
end
