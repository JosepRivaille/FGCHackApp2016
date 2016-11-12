class CreateForums < ActiveRecord::Migration[5.0]
  def change
    create_table :forums do |t|
      t.string :name
      t.integer :visitors
      t.integer :participants

      t.timestamps
    end
  end
end
