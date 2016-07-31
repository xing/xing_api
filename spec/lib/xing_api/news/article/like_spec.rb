describe XingApi::News::Article::Like do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/news/articles/123/likes', {})

      described_class.list('123')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/news/articles/123/like', {})

      described_class.create(123)
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/news/articles/123/like', {})

      described_class.delete(123)
    end
  end
end
