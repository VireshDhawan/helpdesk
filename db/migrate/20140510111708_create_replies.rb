class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.text :content
      t.integer :ticket_id
      t.integer :agent_id

      t.timestamps
    end
    
  	add_index :replies, :ticket_id
    add_index :replies, :agent_id
  end
end
