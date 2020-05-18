# frozen_string_literal: true

# Migration to add events artists join table
class CreateJoinTableEventsArtists < ActiveRecord::Migration[5.2]
  def change
    create_join_table :events, :artists do |t|
      t.index :event_id
      t.index :artist_id
    end
  end
end
