class AttendancesController < ApplicationController
  before_action :set_user, only: %i(edit_one_month update_one_month)
  before_action :logged_in_user, only: %i(update edit_one_month)
  before_action :admin_or_correct_user, only: %i(update edit_one_month update_one_month)
  before_action :set_one_month, only: :edit_one_month
  before_action :admin_user_attendance_edit, only: %i(edit_one_month update_one_month)
  before_action :keisan, only: %i(edit_one_month)

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.round_to( 15.minutes))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.rest_in_at.nil?
      if  @attendance.update_attributes(rest_in_at: Time.current.round_to( 15.minutes))
        flash[:info] ="ゆっくり休憩してください。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.rest_out_at.nil?
      if  @attendance.update_attributes(rest_out_at: Time.current.round_to( 15.minutes))
        flash[:info] ="休憩から上がりました。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.round_to( 15.minutes))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    if @attendance.finished_at.present?
      @total = @attendance.finished_at
      @total = (((@total- @attendance.started_at) / 60) / 60.0) 
      @rest = @attendance.rest_out_at
      @rest = (((@rest - @attendance.rest_in_at) / 60) / 60.0) 
      @total = @total - @rest
      @attendance.update_attributes(day_total_working: @total )
    end
    redirect_to @user
  end

  def edit_one_month
  end

  def update_one_month
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      attendances_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes!(item)
      end
    end
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])
  end

  private
    # 1ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :rest_in_at, :rest_out_at, :day_total_working, :day_regular_working, :day_over_working, :day_night_working, :note])[:attendances]
    end
    
    # beforeフィルター

    # 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
    
    def admin_user_attendance_edit
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end
    end
    
    def keisan
      if @attendance.finished_at.present?
        @total = @attendance.finished_at
        @total = (((@total- @attendance.started_at) / 60) / 60.0) 
        @rest = @attendance.rest_out_at
        @rest = (((@rest - @attendance.rest_in_at) / 60) / 60.0) 
        @total = @total - @rest
        @attendance.update_attributes(day_total_working: @total )
      end
    end
end
