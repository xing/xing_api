describe XingApi::Group::Post do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/some_id/posts', {})

      described_class.list('some_id')
    end
  end

  describe '.find' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/forums/posts/some_id', {})

      described_class.find('some_id')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/groups/forums/posts/some_id', {})

      described_class.delete('some_id')
    end
  end
end
