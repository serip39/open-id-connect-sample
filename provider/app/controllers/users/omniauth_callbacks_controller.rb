class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :azure_activedirectory_v2

  def azure_activedirectory_v2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "azure_activedirectory_v2") if is_navigational_format?
    else
      session["devise.azure_activedirectory_v2_data"] = request.env["omniauth.auth"].except(:extra)
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
