# frozen_string_literal: true

# Migration to add expanse categories table
class CreateExpenseCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_categories do |t|
      t.string :name

      t.references :venue, foreign_key: true

      t.timestamps
    end
  end
end
