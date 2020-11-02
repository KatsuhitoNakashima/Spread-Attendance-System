require 'csv'
 
CSV.generate do |csv|
  column_names = %w(worked_on started_at finished_at rest_in_at rest_out_at)
  csv << column_names
  @attendances.each do |attendance|
    column_values = [
      attendance.worked_on,
      attendance.started_at,
      attendance.finished_at,
      attendance.rest_in_at,
      attendance.rest_out_at
    ]
    csv << column_values
  end
end