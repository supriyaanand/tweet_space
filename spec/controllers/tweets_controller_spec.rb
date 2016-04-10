require 'rails_helper'

describe TweetsController, :type => :controller do
  describe "anonymous user" do
    before :each do
      login_with_user nil
    end

    it "should be redirected to signin" do
      get :get_timeline, {"user" => {"username" => "twitterapi"}}
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "registered user" do
    it "should let a user see all the posts" do
      login_with_user
      get :get_timeline, {"user" => {"username" => "twitterapi"}}
      expect(response).to render_template(:get_timeline)
    end
  end
end