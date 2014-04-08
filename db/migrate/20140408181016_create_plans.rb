class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.float :price
      t.integer :tickets
      t.integer :emails
      t.integer :groups
      t.integer :agents

      t.timestamps
    end
  end
end
