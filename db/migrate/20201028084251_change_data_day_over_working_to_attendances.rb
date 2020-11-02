class ChangeDataDayOverWorkingToAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :day_over_working, :float
  end
end
