module XingApi
  module ResponseHandler
    OAUTH_ERROR_RESPONSES = %w(
      INVALID_OAUTH_CONSUMER
      CONSUMER_MISMATCH
      INVALID_OAUTH_SIGNATURE_METHOD
      INVALID_OAUTH_SIGNATURE
      INVALID_TIMESTAMP
      TIMESTAMP_EXPIRED
      NONCE_ALREADY_USED
      NONCE_MISSING
      INVALID_OAUTH_VERSION
      REQUIRED_PARAMETER_MISSING
    )

    def handle(response)
      return {} if response.code.to_i == 204

      unless (200..299).include?(response.code.to_i)
        raise_failed_response!(response)
      end

      JSON.parse(response.body.to_s, symbolize_names: true)
    rescue JSON::ParserError
      {}
    end

    private

    def raise_failed_response!(response)
      status_code = response.code.to_i
      body = parse_json(response)
      error_class = failed_response_for(status_code, body[:error_name])

      fail error_class.new(status_code, body[:error_name], body[:message], body[:errors])
    end

    def failed_response_for(status_code, error_name)
      case status_code
      when 401
        unauthorized_response_for(error_name)
      when 403
        forbidden_response_for(error_name)
      when (500..504)
        XingApi::ServerError
      end || XingApi::Error
    end

    def unauthorized_response_for(error_name)
      case error_name
      when *OAUTH_ERROR_RESPONSES
        XingApi::OauthError
      when 'INVALID_OAUTH_TOKEN'
        XingApi::InvalidOauthTokenError
      end
    end

    def forbidden_response_for(error_name)
      case error_name
      when 'RATE_LIMIT_EXCEEDED'
        XingApi::RateLimitExceededError
      when 'ACCESS_DENIED'
        XingApi::AccessDeniedError
      when 'INVALID_PARAMETERS'
        XingApi::InvalidParameterError
      end
    end

    def parse_json(response)
      JSON.parse(response.body.to_s, symbolize_names: true)
    rescue JSON::ParserError
      { message: response.body.to_s }
    end
  end
end
