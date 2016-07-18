module XingApi
  class Group
    class Post
      class Comment
        class Like < XingApi::Base
          def self.list(comment_id, options = {})
            request(:get, "/v1/groups/forums/posts/comments/#{comment_id}/likes", options)
          end

          def self.create(comment_id, options = {})
            request(:put, "/v1/groups/forums/posts/comments/#{comment_id}/like", options)
          end

          def self.delete(comment_id, options = {})
            request(:delete, "/v1/groups/forums/posts/comments/#{comment_id}/like", options)
          end
        end
      end
    end
  end
end
