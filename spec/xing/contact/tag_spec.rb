describe Xing::Contact::Tag do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/contacts/user_id/tags', {})

      described_class.list('user_id')
    end
  end
end
