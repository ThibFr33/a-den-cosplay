# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :localisation
      t.string :description
      t.string :photo
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
