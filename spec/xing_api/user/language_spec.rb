describe XingApi::User::Language do

  describe '.update' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/languages/cs', {})

      described_class.update('cs')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/languages/cs', {})

      described_class.delete('cs')
    end
  end

end
