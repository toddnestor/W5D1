class ModifyGoals < ActiveRecord::Migration
  def change
    add_column :goals, :private, :boolean, default: false, null: false
    add_column :goals, :completed, :boolean, default: false, null: false
  end
end
