describe XingApi::User::Photo do
  describe '.update' do
    it 'invokes the correct API call' do
      expect_request_with_body(:put, '/v1/users/me/photo', some: 'body')

      described_class.update(some: 'body')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/photo', {})

      described_class.delete
    end
  end
end
