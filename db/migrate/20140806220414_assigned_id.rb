class AssignedId < ActiveRecord::Migration
  def change
    add_column :tasks, :assigned_id, :integer
  end
end
