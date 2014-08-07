class RmAss < ActiveRecord::Migration
  def change
    remove_column :tasks, :assigned_user_id, :integer
  end
end
