class AddEmailToCompany < ActiveRecord::Migration
  def change
  	add_column :companies, :email, :string
  	add_index :companies, :email
  end
end
