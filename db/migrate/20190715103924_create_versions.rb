# frozen_string_literal: true

class CreateVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :versions do |t|
      t.string :name, null: false
      t.string :title

      t.integer :status, default: 0

      t.references :package, foreign_key: true

      t.text :description
      t.date :publication

      t.timestamps
    end
  end
end
