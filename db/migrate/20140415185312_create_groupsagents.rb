class CreateGroupsagents < ActiveRecord::Migration
  def change
    create_table :groups_agents do |t|
      t.integer :group_id
      t.integer :agent_id

      t.timestamps
    end

    add_index :groups_agents, :group_id
    add_index :groups_agents, :agent_id
  end
end
