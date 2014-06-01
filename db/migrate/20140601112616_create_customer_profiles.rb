class CreateCustomerProfiles < ActiveRecord::Migration
  def change
    create_table :customer_profiles do |t|
      t.string :name
      t.integer :company_id

      t.timestamps
    end

    add_index :customer_profiles,:company_id
  end
end
