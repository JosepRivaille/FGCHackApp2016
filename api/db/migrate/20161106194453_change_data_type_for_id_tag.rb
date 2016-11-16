class ChangeDataTypeForIdTag < ActiveRecord::Migration[5.0]
  def change
    change_column(:users, :idTag, :string)
  end
end
