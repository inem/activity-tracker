class AddEndDateToExercises < ActiveRecord::Migration
  def change
    add_column :exercises, :end_date, :datetime
  end
end
