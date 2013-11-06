describe Xing::Client do
  describe '.configure' do
    it 'accept a block setting default values' do
      block_called = false
      described_class.configure do |client|
        block_called = true
        expect(client).to respond_to :consumer_key=
        expect(client).to respond_to :consumer_secret=
        expect(client).to respond_to :oauth_token=
        expect(client).to respond_to :oauth_token_secret=
      end
      expect(block_called).to be_true
    end
  end

  context 'without global configuration' do
    subject { described_class.new }

    it_behaves_like 'a configurable client'

    %w(consumer_key consumer_secret oauth_token oauth_token_secret).each do |attr|
      it "has an empty #{attr}" do
        expect(subject.send(attr)).to be_nil
      end
    end
  end

  context 'with global configuration' do
    before do
      described_class.configure do |config|
        config.consumer_key       = 'consumer_key'
        config.consumer_secret    = 'consumer_secret'
        config.oauth_token        = 'oauth_token'
        config.oauth_token_secret = 'oauth_token_secret'
      end
    end
    subject { described_class.new }

    it_behaves_like 'a configurable client'

    %w(consumer_key consumer_secret oauth_token oauth_token_secret).each do |attr|
      it "has a default value for #{attr}" do
        expect(subject.send(attr)).to eql(attr)
      end
    end
  end

  describe '#request' do
    subject { described_class.new }

    def set_expectaction(verb, url, body='{}')
      response_stub = stub(:code => 200, :body => body)
      token_stub = mock do
        expects(:request).with(verb, url).returns(response_stub)
      end
      subject.stubs(:access_token).returns(token_stub)
    end

    it 'passes verb, url and options as query_string to the access_token' do
      set_expectaction(:get, '/v1/some_resource/123?param1=1&param2=foobar')

      subject.request(:get, '/v1/some_resource/123', :param1 => 1, :param2 => 'foobar')
    end

    it 'passes options as encoded query_string to the access_token' do
      set_expectaction(:get, '/v1/some_resource/123?param=some+text+%26+more')

      subject.request(:get, '/v1/some_resource/123', :param => 'some text & more')
    end

    it 'parses the response' do
      set_expectaction(:get, '/v1/some_resource', '{"some": "content"}')

      expect(subject.request(:get, '/v1/some_resource')).to eql({:some => 'content'})
    end
  end

  describe '#get_request_token' do
    subject { described_class.new }
    let(:consumer) { stub }
    let(:request_token) {
      stub(
        token: 'request_token',
        secret: 'request_token_secret',
        authorize_url: 'http://authorize.url'
      )
    }

    before { subject.stubs(:consumer).returns(consumer) }

    it 'returns hash with request token data' do
      expected = {
        request_token: 'request_token',
        request_token_secret: 'request_token_secret',
        authorize_url: 'http://authorize.url'
      }

      consumer.stubs(:get_request_token).returns(request_token)

      expect(subject.get_request_token).to eql(expected)
    end

    it 'uses oauth_callback oob by default' do
      consumer.
        expects(:get_request_token).
        with(oauth_callback: 'oob').
        returns(request_token)

      subject.get_request_token
    end

    it 'considers the oauth_callback' do
      consumer.
        expects(:get_request_token).
        with(oauth_callback: 'oauth_callback').
        returns(request_token)

      subject.get_request_token('oauth_callback')
    end
  end

  describe '#get_access_token' do
    subject { described_class.new }
    let(:consumer) { stub }
    let(:token) { 'token' }
    let(:secret) { 'secret' }
    let(:verifier) { '1234' }
    let(:access_token) { stub(token: 'access_token', secret: 'access_token_secret') }
    before { subject.stubs(:consumer).returns(consumer) }
    before do
      OAuth::RequestToken.
        any_instance.
        stubs(:get_access_token).
        returns(access_token)
    end

    it 'returns hash with access token data' do
      expected = {
        access_token: 'access_token',
        access_token_secret: 'access_token_secret'
      }

      expect(subject.get_access_token(verifier, token, secret)).to eql(expected)
    end

    it 'set token and secret values' do
      subject.get_access_token(verifier, token, secret)

      expect(subject.oauth_token).to eql(access_token.token)
      expect(subject.oauth_token_secret).to eql(access_token.secret)
    end

    it 'passes correct parameters to create the oauth request token' do
      request_token = OAuth::RequestToken.new(consumer, token, secret)
      OAuth::RequestToken.
        expects(:new).
        with(consumer, token, secret).
        returns(request_token)

      subject.get_access_token(verifier, token, secret)
    end

    it 'passes verifier to get the access token' do
      OAuth::RequestToken.
        any_instance.
        expects(:get_access_token).
        with(oauth_verifier: verifier).
        returns(access_token)

      subject.get_access_token(verifier, token, secret)
    end
  end
end
