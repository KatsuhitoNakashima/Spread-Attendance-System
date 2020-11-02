require 'csv'

CSV.generate do |csv|
  column_names = %w(name department email)
  csv << column_names
  @users.each do |user|
    column_values = [
      user.name,
      user.department,
      user.email
    ]
    csv << column_values
  end
end