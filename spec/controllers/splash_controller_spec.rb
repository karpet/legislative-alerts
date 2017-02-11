require 'rails_helper'

RSpec.describe SplashController, :type => :controller do
  before :each do
    begin
      Devise
      sign_out :user
    rescue NameError
    end
  end

  after do
    ENV['HTTP_AUTH_USERNAME'] = nil
    ENV['HTTP_AUTH_PASSWORD'] = nil
  end

  it "should return the index page" do
    get :index
    expect(response).to render_template( :index )
  end

  it "should not request authentication even if http_auth is set" do
    ENV['HTTP_AUTH_USERNAME'] = "user"
    ENV['HTTP_AUTH_PASSWORD'] = "pass"

    get :index
    expect(response).to render_template( :index )

    ENV['HTTP_AUTH_USERNAME'] = nil
    ENV['HTTP_AUTH_PASSWORD'] = nil
  end

  context "with views" do
    render_views
    it "should return the index page with the correct google tracking code" do
      ENV['GOOGLE_ANALYTICS_SITE_ID'] = '123456'

      get :index
      expect( response.body ).to include( "ga('create', '123456'" );

      ENV['GOOGLE_ANALYTICS_SITE_ID'] = nil
    end
  end
end
