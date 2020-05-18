class CreateJoinTableWorkspacesEvents < ActiveRecord::Migration[5.2]
  def change
    create_join_table :workspaces, :events do |t|
      t.index :workspace_id
      t.index :event_id
    end
  end
end
