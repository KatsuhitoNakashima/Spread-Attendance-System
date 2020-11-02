class AddDayRegularWorkingToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :day_regular_working, :datetime
  end
end
