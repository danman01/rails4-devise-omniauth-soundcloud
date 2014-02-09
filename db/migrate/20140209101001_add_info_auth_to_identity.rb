class AddInfoAuthToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :info_hash, :text
    add_column :users, :avatar_url, :string
    add_column :identities, :profile_url, :string
    rename_column :users, :first_name, :name
    remove_column :users, :last_name

  end
end
