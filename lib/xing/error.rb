module Xing
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

  class OauthError             < Xing::Error; end
  class ServerError            < Xing::Error; end
  class AccessDeniedError      < Xing::Error; end
  class InvalidParameterError  < Xing::Error; end
  class InvalidOauthTokenError < Xing::Error; end
  class RateLimitExceededError < Xing::Error; end
end
