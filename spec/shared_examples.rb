shared_examples "a Xing API call" do
  it "should pass the correct parameters" do
    Xing::Client.any_instance.expects(:request).with do |*params|
      params.last[:fields] == 'id,display_name'
    end

    argument_count = (described_class.method(method).arity + 1).abs
    arguments = ['argument'] * argument_count
    described_class.send(method, *arguments, :fields => 'id,display_name')
  end
end

shared_examples "a configurable client" do
  context "with configuration as parameters" do
    let(:configuration) do
      {
        :consumer_key => "consumer_key",
        :consumer_secret => "consumer_secret",
        :oauth_token => "oauth_token",
        :oauth_token_secret => "oauth_token_secret"
      }
    end

    subject { described_class.new(configuration) }

    %w(consumer_key consumer_secret oauth_token oauth_token_secret).each do |attr|
      it "should have the configured attribute for #{attr}" do
        subject.send(attr).should be configuration[attr.to_sym]
      end
    end
  end
end
