module XingApi
  module News
    class Page < XingApi::Base
      def self.find(page_id, options = {})
        request(:get, "/v1/news/pages/#{page_id}", options)
      end

      def self.list_editable(options = {})
        request(:get, '/v1/users/me/news/pages/editable', options)
      end

      def self.list_following(options = {})
        request(:get, '/v1/users/me/news/pages/following', options)
      end
    end
  end
end
