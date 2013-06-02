describe Xing::Bookmark do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/bookmarks/other_user', {})

      described_class.list('other_user')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/bookmarks/other_user', {})

      described_class.create('other_user')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/bookmarks/other_user', {})

      described_class.delete('other_user')
    end
  end
end
