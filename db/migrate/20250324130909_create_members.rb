# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members do |t|
      t.string :pseudo
      t.text :presentation
      t.string :photos

      t.timestamps
    end
  end
end
