module Xing
  class Bookmark < Xing::Base

    def self.list(bookmark_id, options={})
      request(:get, "/v1/users/me/bookmarks/#{bookmark_id}", options)
    end

    def self.create(bookmark_id, options={})
      request(:put, "/v1/users/me/bookmarks/#{bookmark_id}", options)
    end

    def self.delete(bookmark_id, options={})
      request(:delete, "/v1/users/me/bookmarks/#{bookmark_id}", options)
    end

  end
end
