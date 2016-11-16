class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      # :idTAg to :id_tag
      t.integer :id_tag

      t.timestamps
    end
  end
end
