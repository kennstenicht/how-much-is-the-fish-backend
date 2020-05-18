class CreateJoinTableWorkspacesArtists < ActiveRecord::Migration[5.2]
  def change
    create_join_table :workspaces, :artists do |t|
      t.index :workspace_id
      t.index :artist_id
    end
  end
end
