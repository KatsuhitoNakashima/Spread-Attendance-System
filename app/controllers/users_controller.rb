class UsersController < ApplicationController
  before_action :set_user, only: %i(show edit update  destroy edit_basic_info update_basic_info)
  before_action :logged_in_user, only: %i(index destroy edit_basic_info update_basic_info)
  before_action :admin_user, only: %i(edit update destroy edit_basic_info update_basic_info index)
  before_action :set_one_month, only: :show

  def index
    #@users = User.paginate(page: params[:page])
    @users = User.all
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_users_csv(@users)
      end
    end
  end
  
  def send_users_csv(users)
    csv_data = CSV.generate do |csv|
      header = %w(id name department)
      csv << header
      
      users.each do |user|
        values = [user.id,user.name,user.department]
        csv << values
      end
      send_data(csv_data, filename: "users.csv")
    end
  end

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      flash[:success] = "#{@user.name}の情報を更新しました。"
    else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation, :bikou, :hourpay)
    end

    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time, :bikou, :hourpay)
    end
end