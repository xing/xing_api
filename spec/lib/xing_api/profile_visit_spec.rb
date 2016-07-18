describe XingApi::ProfileVisit do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/visits', {})

      described_class.list
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/user_id/visits', {})

      described_class.create('user_id')
    end
  end
end
