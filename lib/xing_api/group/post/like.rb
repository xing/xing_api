module XingApi
  class Group
    class Post
      class Like < XingApi::Base
        def self.list(post_id, options = {})
          request(:get, "/v1/groups/forums/posts/#{post_id}/likes", options)
        end

        def self.create(post_id, options = {})
          request(:put, "/v1/groups/forums/posts/#{post_id}/like", options)
        end

        def self.delete(post_id, options = {})
          request(:delete, "/v1/groups/forums/posts/#{post_id}/like", options)
        end
      end
    end
  end
end
