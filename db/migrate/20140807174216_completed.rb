class Completed < ActiveRecord::Migration
  def change
    remove_column :tasks, :complete, :boolean
    add_column :tasks, :completed, :boolean
  end
end
