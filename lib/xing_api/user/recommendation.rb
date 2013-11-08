module XingApi
  class User::Recommendation < XingApi::Base

    def self.list(options={})
      request(:get, '/v1/users/me/network/recommendations', options)
    end

    def self.delete(user_id, options={})
      request(:delete, "/v1/users/me/network/recommendations/user/#{user_id}", options)
    end

  end
end
