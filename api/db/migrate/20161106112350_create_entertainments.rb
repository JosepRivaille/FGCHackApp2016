class CreateEntertainments < ActiveRecord::Migration[5.0]
  def change
    create_table :entertainments do |t|
      t.string :name
      t.text :description
      t.string :category
      t.float :score

      t.timestamps
    end
  end
end
