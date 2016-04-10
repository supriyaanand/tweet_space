require 'grackle'

class TwitterClient

  def index(username)
    begin
      client.statuses.user_timeline.json? :screen_name => username, :count => Settings.num_of_tweets_to_retrieve
    rescue Grackle::TwitterError => ex
      Rails.logger.error("Twitter Client Error #{ex.inspect}")
      return
    end
  end

  private

  def client
    @client ||= create_client
  end

  def create_client
    @client = Grackle::Client.new(:auth => {
                                      :type => :oauth,
                                      :consumer_key => Settings.consumer_key, :consumer_secret => Settings.consumer_secret,
                                      :token => Settings.access_token, :token_secret => Settings.access_token_secret
                                  },
                                  :ssl => true)
  end
end