describe XingApi::Group do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/groups', {})

      described_class.list('me')
    end
  end

  describe '.search' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/find', keywords: 'keywords')

      described_class.search('keywords')
    end
  end

  describe '.read' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/groups/some_id/read', {})

      described_class.read('some_id')
    end
  end

  describe '.join' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/groups/some_id/memberships', {})

      described_class.join('some_id')
    end
  end

  describe '.leave' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/groups/some_id/memberships', {})

      described_class.leave('some_id')
    end
  end
end
