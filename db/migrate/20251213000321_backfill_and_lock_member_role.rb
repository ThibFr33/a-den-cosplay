class BackfillAndLockMemberRole < ActiveRecord::Migration[7.1]
  def up
    # 1) Backfill des anciens membres
    execute <<~SQL
      UPDATE members
      SET role = 'member'
      WHERE role IS NULL
    SQL

    # 2) Default DB
    change_column_default :members, :role, from: nil, to: "member"

    # 3) Contrainte NOT NULL
    change_column_null :members, :role, false
  end

  def down
    change_column_null :members, :role, true
    change_column_default :members, :role, from: "member", to: nil
  end
end
