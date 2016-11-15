class AddTotalVotesEntertainment < ActiveRecord::Migration[5.0]
  def change
    add_column :entertainments, :total_votes, :integer
  end
end
