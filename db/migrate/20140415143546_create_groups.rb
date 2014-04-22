class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :company_id

      t.timestamps
    end

    add_index :groups, :name
    add_index :groups, :company_id
  end
end
