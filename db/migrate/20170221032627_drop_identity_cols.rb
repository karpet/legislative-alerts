class DropIdentityCols < ActiveRecord::Migration[5.0]
  def change
    remove_column :identities, :name
    remove_column :identities, :nickname
    remove_column :identities, :phone
    remove_column :identities, :urls
  end
end
