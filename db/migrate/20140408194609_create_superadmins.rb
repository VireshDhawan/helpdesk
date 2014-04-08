class CreateSuperadmins < ActiveRecord::Migration
  def change
    create_table :superadmins do |t|
      t.string :name

      t.timestamps
    end
  end
end
