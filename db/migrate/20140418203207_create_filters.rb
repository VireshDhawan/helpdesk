class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.string :from_email
      t.string :delivered_to
      t.string :subject_with_keywords
      t.string :body_with_keywords
      t.boolean :archive
      t.boolean :trash
      t.boolean :spam
      t.integer :label_id
      t.integer :group_id
      t.integer :agent_id
      t.integer :company_id

      t.timestamps
    end

    add_index :filters, :from_email, :unique => true
    add_index :filters, :delivered_to, :unique => true
    add_index :filters, :subject_with_keywords, :unique => true
    add_index :filters, :body_with_keywords, :unique => true
    add_index :filters, :label_id, :unique => true
    add_index :filters, :group_id, :unique => true
    add_index :filters, :agent_id, :unique => true
    add_index :filters, :company_id, :unique => true
  end
end
