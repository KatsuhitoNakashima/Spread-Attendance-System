module SessionsHelper

  # 引数に渡されたユーザーオブジェクトでログインします。
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # セッションと@current_userを破棄します
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # 現在ログイン中のユーザーがいる場合オブジェクトを返します。
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id]) # ||　→　or演算子
      # ↑ if @current_user.nil?
      #     @current_user = User.find_by(id: session[:user_id])
      #   else
      #     @current_user
      #   end
    end
  end
  
  # 現在ログイン中のユーザーがいればtrue、そうでなければfalseを返します。
    # ログイン状態を論理値（trueかfalse）で返すヘルパーメソッド（logged_in?）を定義.
    #  trueはログイン状態、falseはログアウト状態を表す
    # そのため否定演算子!を利用
  def logged_in?　
    !current_user.nil?
  end
  
end