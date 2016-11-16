class ChangeDataTypeForIdTag < ActiveRecord::Migration[5.0]
  def change
    #:idTag to :id_tag
    change_column(:users, :id_tag, :string)
  end
end
