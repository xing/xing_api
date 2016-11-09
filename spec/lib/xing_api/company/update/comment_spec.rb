describe XingApi::Company::Update::Comment do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/companies/updates/some_id/comments', {})

      described_class.list('some_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/companies/updates/some_id/comments', content: 'My comment')

      described_class.create('some_id', 'My comment')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/companies/updates/some_id/comments/another_id', {})

      described_class.delete('some_id', 'another_id')
    end
  end
end
