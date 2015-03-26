shared_examples 'a Xing API call' do
  let(:method_name) do
    self.class.metadata[:parent_example_group][:description].delete('.')
  end
  let(:arguments) do
    ['arg'] * (described_class.method(method_name).arity.abs - 1)
  end

  it 'passes optional parameters correctly' do
    XingApi::Client.any_instance.expects(:request).with do |*params|
      params.last[:fields] == 'id,display_name'
    end

    described_class.send(method_name, *arguments, fields: 'id,display_name')
  end
end

shared_examples 'a configurable client' do
  context 'with configuration as parameters' do
    let(:configuration) do
      {
        consumer_key: 'consumer_key',
        consumer_secret: 'consumer_secret',
        oauth_token: 'oauth_token',
        oauth_token_secret: 'oauth_token_secret'
      }
    end

    subject { described_class.new(configuration) }

    %w(consumer_key consumer_secret oauth_token oauth_token_secret).each do |attr|
      it "has the configured attribute for #{attr}" do
        expect(subject.send(attr)).to eq(configuration[attr.to_sym])
      end
    end
  end
end
