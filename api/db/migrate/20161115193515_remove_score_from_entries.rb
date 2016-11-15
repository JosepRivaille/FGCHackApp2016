class RemoveScoreFromEntries < ActiveRecord::Migration[5.0]
  def change
    remove_column :entries, :score
  end
end
