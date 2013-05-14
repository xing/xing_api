module Xing
  class Base
    class << self
      [:get, :post, :put, :delete].each do |http_verb|
        define_method http_verb do |url, options={}|
          client = options.delete(:client) || default_client
          client.send(http_verb, url, options)
        end
      end
    end

    private

    def self.default_client
      Xing::Client.new
    end
  end
end
