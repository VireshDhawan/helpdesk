class CreateForwardingAddresses < ActiveRecord::Migration
  def change
    create_table :forwarding_addresses do |t|
    	t.string :from
    	t.string :to
    	t.string :alias_name
    	t.string :bcc_to
    	t.boolean :spam_filter
    	t.boolean :use_agents_name
    	t.integer :company_id

      	t.timestamps
    end

    add_index :forwarding_addresses,:to,:unique => true
    add_index :forwarding_addresses,:from
    add_index :forwarding_addresses,:alias_name
  end
end
