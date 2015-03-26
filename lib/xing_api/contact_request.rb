module XingApi
  class ContactRequest < XingApi::Base
    def self.list(options = {})
      request(:get, '/v1/users/me/contact_requests', options)
    end

    def self.create(user_id, options = {})
      request(:post, "/v1/users/#{user_id}/contact_requests", options)
    end

    def self.accept(user_id, options = {})
      request(:put, "/v1/users/#{user_id}/contact_requests/me/accept", options)
    end

    def self.deny(user_id, options = {})
      request(:delete, "/v1/users/me/contact_requests/#{user_id}", options)
    end

    def self.sent(options = {})
      request(:get, '/v1/users/me/contact_requests/sent', options)
    end
  end
end
