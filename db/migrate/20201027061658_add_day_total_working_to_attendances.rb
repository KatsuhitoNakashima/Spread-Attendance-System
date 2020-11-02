class AddDayTotalWorkingToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :day_total_working, :float
  end
end
