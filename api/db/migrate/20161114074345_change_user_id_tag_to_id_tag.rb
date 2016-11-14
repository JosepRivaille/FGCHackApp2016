class ChangeUserIdTagToIdTag < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :idTag, :id_tag
  end
end
