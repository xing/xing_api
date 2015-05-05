module XingApi
  class User < XingApi::Base
    def self.find(user_id, options = {})
      request(:get, "/v1/users/#{user_id}", options)
    end

    def self.me(options = {})
      find('me', options)
    end

    def self.id_card(options = {})
      request(:get, '/v1/users/me/id_card', options)
    end

    def self.activities(user_id, options = {})
      request(:get, "/v1/users/#{user_id}/feed", options)
    end

    def self.network_activities(options = {})
      request(:get, '/v1/users/me/network_feed', options)
    end

    def self.shared(user_id, options = {})
      request(:get, "/v1/users/#{user_id}/contacts/shared", options)
    end

    def self.paths(user_id, options = {})
      request(:get, "/v1/users/me/network/#{user_id}/paths", options)
    end

    def self.find_by_emails(emails, options = {})
      request(:get, '/v1/users/find_by_emails', { emails: emails }.merge(options))
    end

    def self.groups(user_id, options = {})
      request(:get, "/v1/users/#{user_id}/groups", options)
    end

    def self.status_message(message, options = {})
      request(:post, '/v1/users/me/status_message', { message: message }.merge(options))
    end

    def self.share_link(uri, options = {})
      request(:post, '/v1/users/me/share/link', { uri: uri }.merge(options))
    end

    def self.update(options = {})
      request(:put, '/v1/users/me', options)
    end
  end
end
