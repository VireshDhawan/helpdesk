class AddCompanyIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :company_id, :integer
  end
end
