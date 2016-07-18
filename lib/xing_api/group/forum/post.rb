module XingApi
  class Group
    class Forum
      class Post < XingApi::Base
        def self.list(forum_id, options = {})
          request(:get, "/v1/groups/forums/#{forum_id}/posts", options)
        end

        def self.create(forum_id, title, content, options = {})
          request(:post, "/v1/groups/forums/#{forum_id}/posts", { title: title, content: content }.merge(options))
        end
      end
    end
  end
end
