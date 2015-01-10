module XingApi
  class Base
    class << self

      def request(http_verb, url, options={})
        client = options.delete(:client) || default_client
        client.request(http_verb, url, options)
      end

      def request_with_body(http_verb, url, body_hash, options={})
        client = options.delete(:client) || default_client
        client.request_with_body(http_verb, url, body_hash)
      end

      private

      def default_client
        XingApi::Client.new
      end

    end
  end
end
