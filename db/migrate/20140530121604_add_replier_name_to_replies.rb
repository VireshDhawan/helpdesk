class AddReplierNameToReplies < ActiveRecord::Migration
  def change
  	add_column :replies, :replier_name, :string
  end
end
