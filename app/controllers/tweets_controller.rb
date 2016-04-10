require 'twitter-text'
require 'json/add/struct'

class TweetsController < ApplicationController
  include Twitter::Autolink
  before_filter :authenticate_user!

  def get_timeline
    @username = params["user"]["username"]
    tweets = TwitterClient.new.index(@username)
    if tweets.nil?
      redirect_to root_url, :notice => "Something went wrong. Please verify user name and try again."
      return
    end
    @tweets = JSON.parse(tweets.to_json, :create_additions => true)
    @name = @tweets[0]["table"]["user"]["table"]["name"]
    @profile_img_url = @tweets[0]["table"]["user"]["table"]["profile_image_url_https"]
    @tweet_array = Array.new
    @tweets.each do |tweet|
      tweet.each do |key, tweet_details|
        if tweet_details.class == Hash
          if tweet_details.has_key?("text")
            tweet_text = auto_link(tweet_details["text"])
            @tweet_array.push({:created_at => tweet_details["created_at"],
                               :text => tweet_text,
                              })
          end
        end
      end
    end
    @results = {:username => @username, :name => @name, :profile_img_url => @profile_img_url, :tweets_array => @tweet_array}
    @results
  end
end
