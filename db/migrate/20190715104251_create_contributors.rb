# frozen_string_literal: true

class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.string :type
      t.references :version, foreign_key: true
      t.references :developer, foreign_key: true

      t.index :type

      t.timestamps
    end
  end
end
