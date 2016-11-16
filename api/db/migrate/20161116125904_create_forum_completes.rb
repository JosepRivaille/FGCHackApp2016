class CreateForumCompletes < ActiveRecord::Migration[5.0]
  def change
    create_table :forum_completes do |t|

      t.timestamps
    end
  end
end
