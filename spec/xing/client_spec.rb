describe Xing::Client do
  describe ".configure" do
    it "accept a block setting default values" do
      block_called = false
      described_class.configure do |client|
        block_called = true
        client.should respond_to :consumer_key=
        client.should respond_to :consumer_secret=
        client.should respond_to :oauth_token=
        client.should respond_to :oauth_token_secret=
      end
      block_called.should be_true
    end
  end

  context "without global configuration" do
    subject { described_class.new }

    it_behaves_like "a configurable client"

    %w(consumer_key consumer_secret oauth_token oauth_token_secret).each do |attr|
      it "should have an empty #{attr}" do
        subject.send(attr).should be_nil
      end
    end
  end

  context "with global configuration" do
    before do
      described_class.configure do |config|
        config.consumer_key = "consumer_key"
        config.consumer_secret = "consumer_secret"
        config.oauth_token = "oauth_token"
        config.oauth_token_secret = "oauth_token_secret"
      end
    end
    subject { described_class.new }

    it_behaves_like "a configurable client"

    %w(consumer_key consumer_secret oauth_token oauth_token_secret).each do |attr|
      it "should have a default value for #{attr}" do
        subject.send(attr).should == attr
      end
    end
  end

  [:get, :post, :put, :delete].each do |http_verb|
    describe "##{http_verb}" do
      subject { described_class.new }

      def set_expectaction(verb, url)
        response_stub = stub(:body => '{}')
        token_stub = mock do
          expects(:request).with(verb, url).returns(response_stub)
        end
        subject.stubs(:access_token).returns(token_stub)
      end

      it "should pass url and options as query_string to the access_token" do
        set_expectaction(http_verb, '/v1/some_resource/123?param1=1&param2=foobar')

        subject.send(http_verb, "/v1/some_resource/123", :param1 => 1, :param2 => 'foobar')
      end

      it "should pass options as encoded query_string to the access_token" do
        set_expectaction(http_verb, '/v1/some_resource/123?param=some+text+%26+more')

        subject.send(http_verb, "/v1/some_resource/123", :param => 'some text & more')
      end

    end
  end
end
