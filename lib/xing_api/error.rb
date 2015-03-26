module XingApi
  class Error < StandardError
    attr_reader :status_code, :name, :text

    def initialize(status_code, name = '', text = '')
      @status_code = status_code
      @name = name
      @text = text
      super(text)
    end

    def to_s
      [status_code, name, text].join(' - ')
    end
  end

  class OauthError             < XingApi::Error; end
  class ServerError            < XingApi::Error; end
  class AccessDeniedError      < XingApi::Error; end
  class InvalidParameterError  < XingApi::Error; end
  class InvalidOauthTokenError < XingApi::Error; end
  class RateLimitExceededError < XingApi::Error; end
end
