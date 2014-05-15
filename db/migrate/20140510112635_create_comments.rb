class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :ticket_id
      t.integer :agent_id

      t.timestamps
    end

    add_index :comments, :agent_id
    add_index :comments, :ticket_id

  end
end
