class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name
      t.text :content
      t.string :tags
      # For scope of the snippet. Either company wide snippet
      # or Agent's personal snippet
      # true for company. false for agent
      t.boolean :scope 
      t.references :snippetable, polymorphic: true

      t.timestamps
    end

    add_index :snippets, :name
    add_index :snippets, :content
    add_index :snippets, :tags
    add_index :snippets, :snippetable_id
    add_index :snippets, :snippetable_type
  end
end
