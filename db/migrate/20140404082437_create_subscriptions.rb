class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :billing_period
      t.integer :company_id
      t.integer :plan_id
      t.datetime :last_payment_at

      t.timestamps
    end
  end
end
