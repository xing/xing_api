describe XingApi::User::PrivateAddress do
  describe '.update' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/private_address', {})

      described_class.update
    end
  end
end
