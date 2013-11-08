module XingApi
  class Base
    class << self

      def request(http_verb, url, options={})
        client = options.delete(:client) || default_client
        client.request(http_verb, url, options)
      end

      private

      def default_client
        XingApi::Client.new
      end

    end
  end
end
