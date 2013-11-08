module XingApi
  class Bookmark < XingApi::Base

    def self.list(options={})
      request(:get, "/v1/users/me/bookmarks", options)
    end

    def self.create(user_id, options={})
      request(:put, "/v1/users/me/bookmarks/#{user_id}", options)
    end

    def self.delete(user_id, options={})
      request(:delete, "/v1/users/me/bookmarks/#{user_id}", options)
    end

  end
end
