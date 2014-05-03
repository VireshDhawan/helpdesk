class CreateMailgunApis < ActiveRecord::Migration
  def change
    create_table :mailgun_apis do |t|
      t.string :key

      t.timestamps
    end

    add_index :mailgun_apis, :key, unique: true

  end
end
