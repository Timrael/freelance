class CreateProjects < ActiveRecord::Migration
  def up
    create_table :projects do |t|
      t.integer :author_id, :null => false
      t.string :title, :null => false
      t.text :description, :null => false
      t.string :condition, :null => false
      t.timestamps
    end
  end

  def down
    drop_table :projects
  end
end
