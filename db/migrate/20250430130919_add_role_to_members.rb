class AddRoleToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :role, :string, null: false, default: "member"
    add_index :members, :role

  end
end
