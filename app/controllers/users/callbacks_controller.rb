class Users::CallbacksController < Devise::OmniauthCallbacksController
  def spotify
    @user = User.from_omniauth(auth)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
