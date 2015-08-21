describe XingApi::ResponseHandler do
  include XingApi::ResponseHandler

  describe '.handle' do
    it 'returns an empty hash for a 204 response' do
      expect(handle_response(204, 'some body')).to be_eql({})
    end

    it 'returns the parsed body for success response' do
      expect(handle_response(200, some: 'json')).to be_eql(some: 'json')
    end

    it 'returns an empty hash for no json body response' do
      expect(handle_response(201, 'Created successfully.')).to be_eql({})
    end

    it 'raises XingApi::ServerError' do
      expect { handle_response(500, '<html>Error</html>') }.to raise_error(XingApi::ServerError)
    end

    %w(
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
    ).each do |error_name|
      it "raises XingApi::OauthError for #{error_name}" do
        expect { handle_response(401, error_name: error_name) }.to raise_error(XingApi::OauthError)
      end
    end

    it 'raises XingApi::RateLimitExceededError' do
      expect { handle_response(403, error_name: 'RATE_LIMIT_EXCEEDED') }.to raise_error(XingApi::RateLimitExceededError)
    end

    it 'raises XingApi::InvalidOauthTokenError' do
      expect { handle_response(401, error_name: 'INVALID_OAUTH_TOKEN') }.to raise_error(XingApi::InvalidOauthTokenError)
    end

    it 'raises XingApi::AccessDenied' do
      expect { handle_response(403, error_name: 'ACCESS_DENIED') }.to raise_error(XingApi::AccessDeniedError)
    end

    it 'raises XingApi::InvalidParameterError' do
      expect { handle_response(403, error_name: 'INVALID_PARAMETERS') }.to raise_error(XingApi::InvalidParameterError)
    end

    it 'includes error information for failed responses' do
      field_errors = [{ field: 'some_field', reason: 'SOME_REASON' }]
      error_response = {
        error_name: 'SOME_ERROR',
        message: 'some message',
        errors: field_errors
      }
      expected_error_message = XingApi::Error.new(403, 'SOME_ERROR', 'some message', field_errors).message

      expect { handle_response(403, error_response) }.to raise_error(XingApi::Error, expected_error_message)
    end

    it 'includes error information for failed response with no json body' do
      expected_error_message = XingApi::Error.new(403, '', 'some error').message

      expect { handle_response(403, 'some error') }.to raise_error(XingApi::Error, expected_error_message)
    end

    private

    def handle_response(code, body = nil)
      body = body.to_json if body.is_a?(Hash)
      handle(stub(code: code, body: body))
    end
  end
end
