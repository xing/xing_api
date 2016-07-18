module XingApi
  class Group
    class Post
      class Comment < XingApi::Base
        def self.list(post_id, options = {})
          request(:get, "/v1/groups/forums/posts/#{post_id}/comments", options)
        end

        def self.create(post_id, content, options = {})
          request(:post, "/v1/groups/forums/posts/#{post_id}/comments", { content: content }.merge(options))
        end

        def self.delete(comment_id, options = {})
          request(:delete, "/v1/groups/forums/posts/comments/#{comment_id}", options)
        end
      end
    end
  end
end
