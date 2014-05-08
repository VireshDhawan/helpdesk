class ChangeReplyEmailAddColumnsInTickets < ActiveRecord::Migration
  def change
  	change_column :tickets, :reply_email, :string
  	add_column :tickets, :notify_customer, :boolean, :default => false
  	add_column :tickets, :cc, :string
  end
end
