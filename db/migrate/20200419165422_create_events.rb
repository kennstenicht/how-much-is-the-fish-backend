# frozen_string_literal: true

# Migration to add events table
class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.date :date
      t.integer :guests
      t.string :name

      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
