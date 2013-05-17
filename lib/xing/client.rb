module Xing
  class Client
    attr_accessor :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret

    class << self
      attr_accessor :default_options
    end

    def initialize(options={})
      options = (self.class.default_options ||= {}).merge(options)
      @consumer_key = options[:consumer_key]
      @consumer_secret = options[:consumer_secret]
      @oauth_token = options[:oauth_token]
      @oauth_token_secret = options[:oauth_token_secret]
    end

    def self.configure(&block)
      instance = self.new
      yield instance
      self.default_options = instance.send(:to_hash)
    end

    def request(http_verb, url, options={})
      full_url = url + hash_to_params(options)
      parse_response(access_token.request(http_verb, full_url))
    end

    def get_authorize_url
      request_token.authorize_url
    end

    def authorize(verifier)
      access_token = request_token.get_access_token(:oauth_verifier => verifier)
      self.oauth_token = access_token.token
      self.oauth_token_secret = access_token.secret
      self.class.default_options[:consumer_key] = consumer_key
      self.class.default_options[:consumer_secret] = consumer_secret
      self.class.default_options[:oauth_token] = oauth_token
      self.class.default_options[:oauth_token_secret] = oauth_token_secret
      true
    end

    private

    def to_hash
      {
        :consumer_key => consumer_key,
        :consumer_secret => consumer_secret,
        :oauth_token => oauth_token,
        :oauth_token_secret => oauth_token_secret
      }
    end

    def request_token
      @request_token ||= consumer.get_request_token
    end

    def consumer
      OAuth::Consumer.new(consumer_key, consumer_secret, default_options)
    end

    def access_token
      OAuth::AccessToken.new(consumer, oauth_token, oauth_token_secret)
    end

    def parse_response(response)
      JSON.parse(response.body, :symbolize_names => true)
    end

    def default_options
      {
        :site               => "http://main-mark-schmidt.env.xing.com:3007",
        :request_token_path => "/v1/request_token",
        :authorize_path     => "/v1/authorize",
        :access_token_path  => "/v1/access_token",
        :signature_method   => 'PLAINTEXT',
        :oauth_version      => '1.0',
        :scheme             => :query_string
      }
    end

    def hash_to_params(hash)
      "?" + hash.map {|k,v| "#{k}=#{CGI.escape(v.to_s)}"}.join("&")
    end

  end
end
