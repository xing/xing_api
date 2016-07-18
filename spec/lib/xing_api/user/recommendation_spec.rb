describe XingApi::User::Recommendation do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/network/recommendations', {})

      described_class.list
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/network/recommendations/user/user_id', {})

      described_class.delete('user_id')
    end
  end
end
