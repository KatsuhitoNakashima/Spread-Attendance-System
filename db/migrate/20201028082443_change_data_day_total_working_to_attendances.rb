class ChangeDataDayTotalWorkingToAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :day_night_working, :float
  end
end
