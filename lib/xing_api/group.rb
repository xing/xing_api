module XingApi
  class Group < XingApi::Base
    def self.list(user_id, options = {})
      request(:get, "/v1/users/#{user_id}/groups", options)
    end

    def self.search(keywords, options = {})
      request(:get, '/v1/groups/find', { keywords: keywords }.merge(options))
    end

    def self.read(group_id, options = {})
      request(:put, "/v1/groups/#{group_id}/read", options)
    end

    def self.join(group_id, options = {})
      request(:post, "/v1/groups/#{group_id}/memberships", options)
    end

    def self.leave(group_id, options = {})
      request(:delete, "/v1/groups/#{group_id}/memberships", options)
    end
  end
end
