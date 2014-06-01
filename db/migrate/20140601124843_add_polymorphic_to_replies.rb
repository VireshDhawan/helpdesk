class AddPolymorphicToReplies < ActiveRecord::Migration

  def change
  	remove_column :replies, :agent_id
  	remove_column :replies, :replier_name

  	change_table :replies do |t|
  		t.references :replier, polymorphic: true
  	end
  	
  	add_index :replies, :replier_id
  	add_index :replies, :replier_type
  end

end
