require 'rails_helper'
require_relative '../../app/services/twitter_client'

describe "TwitterClient" do
  describe "#index" do
    it 'fetches tweets from Twitter' do
      VCR.use_cassette('user_timeline') do
        tweets = TwitterClient.new.index("twitterapi")
        expect(tweets).not_to be_empty
      end
    end

    it 'returns nil if user was not found or there were no public tweets' do
      VCR.use_cassette('user_timeline_invalid_user') do
        response = TwitterClient.new.index("jijlkpipi0909")
        expect(response).to be_nil
      end
    end
  end
end
