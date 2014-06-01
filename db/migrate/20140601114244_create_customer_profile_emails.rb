class CreateCustomerProfileEmails < ActiveRecord::Migration
  def change
    create_table :customer_profile_emails do |t|
      t.string :email
      t.integer :customer_profile_id

      t.timestamps
    end

    add_index :customer_profile_emails,:email
    add_index :customer_profile_emails,:customer_profile_id
    
  end
end
