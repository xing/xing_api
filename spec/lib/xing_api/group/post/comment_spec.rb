describe XingApi::Group::Post::Comment do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/forums/posts/some_id/comments', {})

      described_class.list('some_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/groups/forums/posts/some_id/comments', content: 'content')
      described_class.create('some_id', 'content')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/groups/forums/posts/comments/some_id', {})

      described_class.delete('some_id')
    end
  end
end
