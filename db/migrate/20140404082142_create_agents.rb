class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :role, default: true #true for 'Admin' & false for 'Agent'
      t.string :signature
      t.string :api_token
      t.integer :company_id
      t.boolean :allow_reporting , default: false
      t.boolean :allow_agent_management , default: false
      t.boolean :allow_to_invite , default: false
      t.boolean :allow_billing_management , default: false
      t.boolean :allow_company_management , default: false
      t.boolean :allow_subscription_management , default: false

      t.timestamps
    end
  end
end
