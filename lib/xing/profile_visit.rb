module Xing
  class ProfileVisit < Xing::Base

    def self.list(options={})
      request(:get, '/v1/users/me/visits', options)
    end

    def self.create(user_id, options={})
      request(:post, "/v1/users/#{user_id}/visits", options)
    end

  end
end
