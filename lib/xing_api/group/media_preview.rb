module XingApi
  class Group
    class MediaPreview < XingApi::Base
      def self.create(url, options = {})
        request(:post, '/v1/groups/media_previews', { url: url }.merge(options))
      end
    end
  end
end
