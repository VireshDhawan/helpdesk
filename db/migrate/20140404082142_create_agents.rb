class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :role, default: true #true for 'Admin' & false for 'Agent'
      t.string :signature
      t.string :api_token
      t.integer :company_id

      t.timestamps
    end
  end
end
