describe XingApi::Base do
  let(:client) { stub }

  describe '.request' do
    it 'calls request with all parameters on the specified client' do
      client.expects(:request).with(:get, 'url', some: 'parameter')

      described_class.request(:get, 'url', some: 'parameter', client: client)
    end

    it 'calls request with all parameters on the default client' do
      XingApi::Base.stubs(:default_client).returns(client)
      client.expects(:request).with(:get, 'url', some: 'parameter')

      described_class.request(:get, 'url', some: 'parameter')
    end
  end

  describe '.request_with_body' do
    it 'calls request with all parameters on the specified client' do
      client.expects(:request_with_body).with(:post, 'url', some: 'body')

      described_class.request_with_body(:post, 'url', { some: 'body' }, client: client)
    end

    it 'calls request with all parameters on the default client' do
      XingApi::Base.stubs(:default_client).returns(client)
      client.expects(:request_with_body).with(:post, 'url', some: 'body')

      described_class.request_with_body(:post, 'url', some: 'body')
    end
  end
end
