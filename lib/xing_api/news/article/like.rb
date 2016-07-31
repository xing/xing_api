module XingApi
  module News
    class Article
      class Like < XingApi::Base
        def self.list(article_id, options = {})
          request(:get, "/v1/news/articles/#{article_id}/likes", options)
        end

        def self.create(article_id, options = {})
          request(:put, "/v1/news/articles/#{article_id}/like", options)
        end

        def self.delete(article_id, options = {})
          request(:delete, "/v1/news/articles/#{article_id}/like", options)
        end
      end
    end
  end
end
