class AddPublickKeyToMailgunApi < ActiveRecord::Migration
  def change
  	rename_column :mailgun_apis, :key, :private_key
  	add_column :mailgun_apis, :public_key, :string
  end
end
