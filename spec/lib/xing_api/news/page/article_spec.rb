describe XingApi::News::Page::Article do
  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/news/pages/123/articles', source_url: 'source_url', title: 'title')

      described_class.create('123', 'source_url', 'title')
    end
  end

  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/news/pages/123/articles', {})

      described_class.list(123)
    end
  end
end
