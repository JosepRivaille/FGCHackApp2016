class ChangeColumnEntriesUserForeignToInteger < ActiveRecord::Migration[5.0]
  def change
    rename_column :entries, :user, :user_id
    change_column :entries, :user_id, 'integer USING CAST(user_id AS integer)'
  end
end
