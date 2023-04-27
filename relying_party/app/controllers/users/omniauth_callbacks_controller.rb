class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :mdh

  def mdh
    # ユーザーの認証情報を取得
    auth = request.env['omniauth.auth']
    # Userモデルのメソッドを呼び出してユーザーを取得
    @user = User.from_omniauth(auth)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'MDH') if is_navigational_format?
    else
      session['devise.mdh_data'] = auth
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
