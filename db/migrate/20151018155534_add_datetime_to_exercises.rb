class AddDatetimeToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :start_date, :datetime
  end
end
