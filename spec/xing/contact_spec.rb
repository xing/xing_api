describe Xing::Contact do
  describe '.list' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/contacts', {})

      described_class.list('me')
    end
  end

  describe '.shared' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/user_id/contacts/shared', {})

      described_class.shared('user_id')
    end
  end
end
