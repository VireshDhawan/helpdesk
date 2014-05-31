class AddColorToLabels < ActiveRecord::Migration
  def change
    add_column :labels, :color, :string
  	add_index :labels, :color
  end
end
