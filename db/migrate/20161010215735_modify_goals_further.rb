class ModifyGoalsFurther < ActiveRecord::Migration
  def change
    rename_column :goals, :private, :publicly_viewable
    change_column :goals, :publicly_viewable, :boolean, default: true
  end
end
