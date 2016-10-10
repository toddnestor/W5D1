class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|

      t.timestamps null: false
    end
  end
end
