module XingApi
  class Client
    include XingApi::ResponseHandler

    OAUTH_ATTRIBUTES = [:consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret].freeze
    attr_writer(*OAUTH_ATTRIBUTES)
    attr_accessor :request_token_hash

    class << self
      attr_accessor :default_options

      def configure
        instance = new
        yield instance
        self.default_options = instance.send(:to_hash)
      end
    end # class << self

    def initialize(options = {})
      options = (self.class.default_options ||= {}).merge(options)
      OAUTH_ATTRIBUTES.each do |attribute|
        send "#{attribute}=", options[attribute]
      end
    end

    def request(http_verb, url, options = {})
      full_url = url + hash_to_params(options)
      handle(access_token.request(http_verb, full_url))
    end

    def request_with_body(http_verb, url, body_hash = {})
      handle(access_token.request(http_verb, url, body_hash.to_json, 'Content-Type' => 'application/json'))
    end

    def get_request_token(oauth_callback = 'oob')
      ensure_attributes_are_set! %w(consumer_key consumer_secret)

      request_token = request_token(oauth_callback)
      self.request_token_hash = {
        request_token: request_token.token,
        request_token_secret: request_token.secret,
        authorize_url: request_token.authorize_url
      }
    end

    def get_access_token(verifier, options = {})
      ensure_attributes_are_set! %w(consumer_key consumer_secret)
      options = request_token_hash.merge(options) if request_token_hash

      access_token = rebuild_request_token(options).get_access_token(oauth_verifier: verifier)
      self.oauth_token = access_token.token
      self.oauth_token_secret = access_token.secret
      {
        access_token: access_token.token,
        access_token_secret: access_token.secret
      }
    end

    OAUTH_ATTRIBUTES.each do |attribute|
      define_method(attribute) do
        instance_variable_get("@#{attribute}") || self.class.default_options[attribute]
      end
    end

    private

    def rebuild_request_token(options)
      request_token = options[:request_token] || raise('request_token missing')
      request_token_secret = options[:request_token_secret] || raise('request_token_secret missing')
      OAuth::RequestToken.new(consumer, request_token, request_token_secret)
    end

    def to_hash
      {
        consumer_key:       consumer_key,
        consumer_secret:    consumer_secret,
        oauth_token:        oauth_token,
        oauth_token_secret: oauth_token_secret
      }
    end

    def request_token(oauth_callback)
      @request_token ||= consumer.get_request_token(oauth_callback: oauth_callback)
    end

    def consumer
      OAuth::Consumer.new(consumer_key, consumer_secret, xing_oauth_options)
    end

    def access_token
      OAuth::AccessToken.new(consumer, oauth_token, oauth_token_secret)
    end

    def xing_oauth_options
      {
        site:               ENV['XING_API_SITE'] || 'https://api.xing.com',
        request_token_path: '/v1/request_token',
        authorize_path:     '/v1/authorize',
        access_token_path:  '/v1/access_token',
        signature_method:   'PLAINTEXT',
        oauth_version:      '1.0',
        scheme:             'query_string'
      }
    end

    def hash_to_params(hash)
      return '' if hash.empty?
      '?' + hash.map { |k, v| "#{k}=#{CGI.escape(v.to_s)}" }.join('&')
    end

    def ensure_attributes_are_set!(attribute_names)
      Array(attribute_names).each do |attribute_name|
        raise "#{attribute_name} is missing" unless send(attribute_name)
      end
    end
  end
end
