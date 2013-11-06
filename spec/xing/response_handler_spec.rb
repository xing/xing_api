describe Xing::ResponseHandler do
  include Xing::ResponseHandler

  describe '.handle' do
    it 'returns an empty hash for a 204 response' do
      expect(handle_response(204, 'some body')).to be_eql({})
    end

    it 'returns the parsed body for success response' do
      expect(handle_response(200, some: 'json')).to be_eql({:some => 'json'})
    end

    it 'raises Xing::ServerError' do
      expect { handle_response(500, '<html>Error</html>') }.to raise_error(Xing::ServerError)
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
      it "raises Xing::OauthError for #{error_name}" do
        expect { handle_response(401, error_name: error_name) }.to raise_error(Xing::OauthError)
      end
    end

    it 'raises Xing::RateLimitExceededError' do
      expect { handle_response(403, error_name: 'RATE_LIMIT_EXCEEDED') }.to raise_error(Xing::RateLimitExceededError)
    end

    it 'raises Xing::InvalidOauthTokenError' do
      expect { handle_response(401, error_name: 'INVALID_OAUTH_TOKEN') }.to raise_error(Xing::InvalidOauthTokenError)
    end

    it 'raises Xing::AccessDenied' do
      expect { handle_response(403, error_name: 'ACCESS_DENIED') }.to raise_error(Xing::AccessDeniedError)
    end

    it 'raises Xing::InvalidParameterError' do
      expect { handle_response(403, error_name: 'INVALID_PARAMETERS') }.to raise_error(Xing::InvalidParameterError)
    end

    it 'includes error information for failed responses' do
      error_response = {
        error_name: 'SOME_ERROR',
        message: 'some message'
      }
      expected_error_message = Xing::Error.new(403, 'SOME_ERROR', 'some message').message

      expect { handle_response(403, error_response) }.to raise_error(Xing::Error, expected_error_message)
    end

    it 'includes error information for failed response with no json body' do
      expected_error_message = Xing::Error.new(403, '', 'some error').message

      expect { handle_response(403, 'some error') }.to raise_error(Xing::Error, expected_error_message)
    end

    private

    def handle_response(code, body=nil)
      body = body.to_json if body.is_a?(Hash)
      handle(stub(code: code, body: body))
    end

  end
end
