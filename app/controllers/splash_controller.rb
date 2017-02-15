class SplashController < ApplicationController
  skip_before_action :authenticate

  def index
    @title = 'Home'
  end
end
