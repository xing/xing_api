describe XingApi::Group do
  describe '.search' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/find', keywords: 'keywords')

      described_class.search('keywords')
    end
  end
end
