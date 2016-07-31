module XingApi
  module News
    class Article < XingApi::Base
      def self.find(article_id, options = {})
        request(:get, "/v1/news/articles/#{article_id}", options)
      end

      def self.update(article_id, version, options = {})
        request(:put, "/v1/news/articles/#{article_id}", { version: version }.merge(options))
      end

      def self.delete(article_id, version, options = {})
        request(:delete, "/v1/news/articles/#{article_id}", { version: version }.merge(options))
      end
    end
  end
end
