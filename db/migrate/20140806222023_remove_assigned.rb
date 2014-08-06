class RemoveAssigned < ActiveRecord::Migration
  def change
    remove_column :tasks, :assigned_id, :integer
  end
end
