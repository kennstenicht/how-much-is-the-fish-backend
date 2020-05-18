# frozen_string_literal: true

# Migration to add expanses table
class CreateExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :expenses do |t|
      t.string :name
      t.string :note
      t.decimal :price
      t.integer :quantity

      t.references :expense_category

      t.timestamps
    end
  end
end
