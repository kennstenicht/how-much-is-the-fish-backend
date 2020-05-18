class CreateJoinTableWorkspacesVenues < ActiveRecord::Migration[5.2]
  def change
    create_join_table :workspaces, :venues do |t|
      t.index :workspace_id
      t.index :venue_id
    end
  end
end
