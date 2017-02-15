class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate

  before_action :store_current_location, unless: :devise_controller?

  def authenticate
    unless ENV['HTTP_AUTH_USERNAME'].blank? or ENV['HTTP_AUTH_PASSWORD'].blank?
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['HTTP_AUTH_USERNAME'] && password == ENV['HTTP_AUTH_PASSWORD']
      end
    end
  end

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  private

  def store_current_location
    store_location_for(:user, request.url)
  end

end
