describe XingApi::Group::Post::Like do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/forums/posts/some_id/likes', {})

      described_class.list('some_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/groups/forums/posts/some_id/like', {})
      described_class.create('some_id')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/groups/forums/posts/some_id/like', {})

      described_class.delete('some_id')
    end
  end
end
