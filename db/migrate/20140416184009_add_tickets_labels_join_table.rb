class AddTicketsLabelsJoinTable < ActiveRecord::Migration
  def change
  	create_table :labels_tickets, id: false do |t|
      t.integer :ticket_id
      t.integer :label_id
    end

    add_index :labels_tickets, [:ticket_id, :label_id]
  end
end
