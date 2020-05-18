class CreateJoinTableEventsVenues < ActiveRecord::Migration[5.2]
  def change
    create_join_table :events, :venues do |t|
      t.index :event_id
      t.index :venue_id
    end
  end
end
