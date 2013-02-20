class CreateBids < ActiveRecord::Migration
  def up
    create_table :bids do |t|
      t.references :project, :null => false
      t.references :user, :null => false
      t.text :description, :null => false
      t.integer :price, :null => false
      t.boolean :chosen, :null => false, :default => false
      t.timestamps
    end
  end

  def down
    drop_table :bids
  end
end
