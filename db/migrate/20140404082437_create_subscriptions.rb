class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :billing_period
      t.string :plan
      t.integer :company_id

      t.timestamps
    end
  end
end
