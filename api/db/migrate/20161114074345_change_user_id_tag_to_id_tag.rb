class ChangeUserIdTagToIdTag < ActiveRecord::Migration[5.0]
  def change
    # :idTag to :id_tag
    rename_column :users, :id_tag, :id_tag
  end
end
