class SplashController < ApplicationController
  skip_before_action :authenticate

  def index
  end
end
