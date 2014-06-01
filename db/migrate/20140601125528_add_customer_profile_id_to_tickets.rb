class AddCustomerProfileIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :customer_profile_id, :integer
    add_index :tickets, :customer_profile_id
  end
end
