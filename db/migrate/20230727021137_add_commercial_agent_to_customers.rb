class AddCommercialAgentToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_reference :customers, :commercial_agent,  foreign_key: true
  end
end
