describe XingApi::News::Article do
  describe '.find' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/news/articles/123', {})

      described_class.find('123')
    end
  end

  describe '.update' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/news/articles/123', version: 1)

      described_class.update(123, 1)
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/news/articles/123', version: 1)

      described_class.delete(123, 1)
    end
  end
end
