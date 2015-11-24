class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :description, null: false
      t.string :goal_type, null: false
      t.string :completed, default: 0
      t.integer :user_id, null: false
      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end
