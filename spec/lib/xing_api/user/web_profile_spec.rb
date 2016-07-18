describe XingApi::User::WebProfile do
  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/web_profiles/amazon', {})

      described_class.delete('amazon')
    end
  end
end
