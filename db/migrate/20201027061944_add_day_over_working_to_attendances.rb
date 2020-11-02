class AddDayOverWorkingToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :day_over_working, :datetime
  end
end
