class CreateJoinTableWorkspacesUsers < ActiveRecord::Migration[5.2]
  def change
    create_join_table :workspaces, :users do |t|
      t.index :workspace_id
      t.index :user_id
    end
  end
end
