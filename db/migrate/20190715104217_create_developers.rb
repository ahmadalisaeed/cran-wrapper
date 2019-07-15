# frozen_string_literal: true

class CreateDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :developers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
