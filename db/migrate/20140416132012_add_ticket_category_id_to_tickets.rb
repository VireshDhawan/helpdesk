class AddTicketCategoryIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :ticket_category_id, :integer
    add_index :tickets, :ticket_category_id
  end
end
