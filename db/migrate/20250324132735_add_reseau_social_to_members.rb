class AddReseauSocialToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :reseau_social, :string
  end
end
