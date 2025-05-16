class AddConfirmableToUsers < ActiveRecord::Migration[7.1]
    def up
    # 1) Ajout des colonnes Confirmable
    add_column :users, :confirmation_token,   :string
    add_column :users, :confirmed_at,         :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email,    :string

    # 2) Index unique sur le token de confirmation
    add_index :users, :confirmation_token, unique: true

    # 3) Marquer tous les utilisateurs existants comme confirmés (optionnel)
    execute <<-SQL.squish
      UPDATE users
      SET confirmed_at = CURRENT_TIMESTAMP
      WHERE confirmed_at IS NULL
    SQL
  end

  def down
    # 1) Suppression conditionnelle de l’index
    remove_index :users, column: :confirmation_token, if_exists: true

    # 2) Suppression conditionnelle des colonnes Confirmable
    [:unconfirmed_email, :confirmation_sent_at, :confirmed_at, :confirmation_token].each do |col|
      remove_column :users, col if column_exists?(:users, col)
    end
  end
end
