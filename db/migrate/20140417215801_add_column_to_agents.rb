class AddColumnToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :allow_groups_management, :boolean, :default => false
  end
end
