class AddDefaultVotesValueTo1 < ActiveRecord::Migration[5.0]
  def change
    change_column :entertainments, :total_votes, :integer, :default => 1
  end
end
