module XingApi
  module News
    class Page
      class Article < XingApi::Base
        def self.create(page_id, source_url, title, options = {})
          request(:post, "/v1/news/pages/#{page_id}/articles", { source_url: source_url, title: title }.merge(options))
        end

        def self.list(page_id, options = {})
          request(:get, "/v1/news/pages/#{page_id}/articles", options)
        end
      end
    end
  end
end
