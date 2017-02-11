class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback( 'facebook' )
  end
  def twitter
    generic_callback( 'twitter' )
  end
  def github
    generic_callback( 'github' )
  end
  def google_oauth2
    generic_callback( 'google_oauth2' )
  end

  def generic_callback( provider )
    @user = User.find_for_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def after_sign_in_path_for(resource)
    if resource.email_verified?
      super resource
    else
      finish_signup_path(resource)
    end
  end
end
