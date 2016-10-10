class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :description, null: false
      t.references :user, index: true
      t.timestamps null: false
    end
  end
end
