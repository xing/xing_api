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

      JSON.parse(response.body.to_s, :symbolize_names => true)
    rescue JSON::ParserError
      {}
    end

    private

    def raise_failed_response!(response)
      status_code = response.code.to_i
      body = parse_json(response)
      error_class = failed_response_for(status_code, body[:error_name])

      raise error_class.new(status_code, body[:error_name], body[:message])
    end

    def failed_response_for(status_code, error_name)
      case status_code
      when 401
        case error_name
        when *OAUTH_ERROR_RESPONSES
          XingApi::OauthError
        when 'INVALID_OAUTH_TOKEN'
          XingApi::InvalidOauthTokenError
        end
      when 403
        case error_name
        when 'RATE_LIMIT_EXCEEDED'
          XingApi::RateLimitExceededError
        when 'ACCESS_DENIED'
          XingApi::AccessDeniedError
        when 'INVALID_PARAMETERS'
          XingApi::InvalidParameterError
        end
      when (500..504)
        XingApi::ServerError
      end || XingApi::Error
    end

    def parse_json(response)
      body = JSON.parse(response.body.to_s, :symbolize_names => true)
    rescue JSON::ParserError
      { message: response.body.to_s }
    end

  end
end
