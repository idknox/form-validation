class FixUser < ActiveRecord::Migration
  def change
      remove_column :tasks, :user, :string
      add_column :tasks, :assigned_to, :string
  end
end
