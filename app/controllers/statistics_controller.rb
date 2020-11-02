require 'csv'

class StatisticsController < ApplicationController
  before_action :set_user, only: %i(statistics)
  before_action :set_one_month, only: %i(statistics)
  
  def statistics
    #ここに集計のアクションを全て集める
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  end
  
  
  def attendance
    respond_to do |format|
      format.html
      format.csv do |csv|
        
        attendances = attendance.all
        
        csv_data = CSV.generate do |csv|
          header = %w(user_id worked_on )
end
