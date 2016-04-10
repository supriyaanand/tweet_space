class ApiRequest < ActiveRecord::Base
  validates :username, presence: true, uniqueness: true
  serialize :response, Hash

  def self.cache(username, cache_policy)
    find_or_initialize_by(username: username).cache(cache_policy) do
      if block_given?
        yield
      end
    end
  end

  def cache(cache_policy)
    if new_record? || updated_at < cache_policy.call
      update_attributes(updated_at: Time.zone.now)
      yield
    end
  end
end