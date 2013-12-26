class AddStatesToBidsAndProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :condition
    remove_column :bids, :chosen
    [:bids, :projects].each do |table_name|
      add_column table_name, :state, :string
    end
  end
end
