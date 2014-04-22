class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :customer_name
      t.string :customer_email
      t.string :subject
      t.text :message
      t.text :reply_email
      t.integer :agent_id
      t.integer :group_id
      t.integer :company_id
      t.integer :ticket_category_id

      t.timestamps
    end

    add_index :tickets, :agent_id
    add_index :tickets, :company_id
    add_index :tickets, :group_id
    add_index :tickets, :reply_email
    add_index :tickets, :customer_email
    add_index :tickets, :ticket_category_id
  end
end
