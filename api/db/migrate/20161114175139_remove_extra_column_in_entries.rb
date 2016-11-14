class RemoveExtraColumnInEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :user_id
  end
end
