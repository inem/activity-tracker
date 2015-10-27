class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.string :name
      t.timestamps :start_date
      t.timestamps :end_date

      t.timestamps null: false
    end
  end
end
