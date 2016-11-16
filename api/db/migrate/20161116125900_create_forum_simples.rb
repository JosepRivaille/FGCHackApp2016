class CreateForumSimples < ActiveRecord::Migration[5.0]
  def change
    create_table :forum_simples do |t|

      t.timestamps
    end
  end
end
