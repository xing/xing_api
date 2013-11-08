describe XingApi::Base do
  describe 'self.request' do
    it 'calls request with all parameters on the specified client' do
      client = stub
      client.expects(:request).with(:get, 'url', {:some => 'parameter'})

      described_class.request(:get, 'url', {:some => 'parameter', :client => client})
    end

    it 'calls request with all parameters on the default client' do
      client = stub
      XingApi::Base.stubs(:default_client).returns(client)
      client.expects(:request).with(:get, 'url', {:some => 'parameter'})

      described_class.request(:get, 'url', {:some => 'parameter'})
    end
  end
end
