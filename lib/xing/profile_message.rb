module Xing
  class ProfileMessage < Xing::Base

    def self.find(user_id, options={})
      request(:get, "/v1/users/#{user_id}/profile_message", options)
    end

    def self.update(message, options={})
      request(:put, '/v1/users/me/profile_message', {:message => message}.merge(options))
    end

    def self.delete(options={})
      request(:put, '/v1/users/me/profile_message', {:message => ''}.merge(options))
    end

  end
end
