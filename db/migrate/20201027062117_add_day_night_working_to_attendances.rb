class AddDayNightWorkingToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :day_night_working, :datetime
  end
end
