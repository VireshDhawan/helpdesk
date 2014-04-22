class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :billing_period
      t.integer :company_id
      t.integer :plan_id
      t.datetime :last_payment_at

      t.timestamps
    end

    add_index :subscriptions,:company_id
    add_index :subscriptions,:plan_id
    add_index :subscriptions,:last_payment_at
    add_index :subscriptions,:billing_period
  end
end
