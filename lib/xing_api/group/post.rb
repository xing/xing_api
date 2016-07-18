module XingApi
  class Group
    class Post < XingApi::Base
      def self.list(group_id, options = {})
        request(:get, "/v1/groups/#{group_id}/posts", options)
      end

      def self.find(post_id, options = {})
        request(:get, "/v1/groups/forums/posts/#{post_id}", options)
      end

      def self.delete(post_id, options = {})
        request(:delete, "/v1/groups/forums/posts/#{post_id}", options)
      end
    end
  end
end
