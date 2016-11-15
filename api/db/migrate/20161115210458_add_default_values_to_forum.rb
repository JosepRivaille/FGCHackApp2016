class AddDefaultValuesToForum < ActiveRecord::Migration[5.0]
  def change
    change_column :forums, :visitors, :integer, :default => 1
    change_column :forums, :participants, :integer, :default => 1
  end
end
