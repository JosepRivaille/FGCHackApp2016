class AddScoreToEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :entries, :score, :float
  end
end
