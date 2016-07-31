describe XingApi::News::Page do
  describe '.find' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/news/pages/123', {})

      described_class.find('123')
    end
  end

  describe '.list_editable' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/news/pages/editable', {})

      described_class.list_editable
    end
  end

  describe '.list_following' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/news/pages/following', {})

      described_class.list_following
    end
  end
end
