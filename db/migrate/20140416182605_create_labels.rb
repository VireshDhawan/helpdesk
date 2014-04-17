class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.string :name
      t.integer :company_id

      t.timestamps
    end

    add_index :labels, :name, unique: true
    add_index :labels, :company_id
  end
end
