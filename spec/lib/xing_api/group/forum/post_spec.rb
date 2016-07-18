describe XingApi::Group::Forum::Post do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/forums/some_id/posts', {})

      described_class.list('some_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expected_options = { title: 'title', content: 'content' }
      expect_request(:post, '/v1/groups/forums/some_id/posts', expected_options)

      described_class.create('some_id', 'title', 'content')
    end
  end
end
