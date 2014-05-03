class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :unassigned_tickets, default: false
      t.boolean :assigned_tickets, default: true
      t.boolean :assigned_group, default: true
      t.boolean :reply_all, default: false
      t.boolean :reply_on_my_tickets, default: true
      t.boolean :reply_on_my_group_tickets, default: true
      t.boolean :all_comments, default: false
      t.boolean :comments_on_my_tickets, default: true
      t.boolean :comments_on_my_group_tickets, default: true
      t.integer :agent_id

      t.timestamps
    end

    add_index :notifications, :unassigned_tickets
    add_index :notifications, :assigned_tickets
    add_index :notifications, :assigned_group
    add_index :notifications, :reply_all
    add_index :notifications, :reply_on_my_tickets
    add_index :notifications, :reply_on_my_group_tickets
    add_index :notifications, :all_comments
    add_index :notifications, :comments_on_my_tickets
  	add_index :notifications, :comments_on_my_group_tickets
    add_index :notifications, :agent_id, unique: true

  end
end
