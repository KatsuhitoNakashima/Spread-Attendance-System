class ChangeDataDayRegularWorkingToAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :day_regular_working, :float
  end
end
