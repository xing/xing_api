describe Xing::Contact do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/contacts', {})

      Xing::Contact.list('me')
    end
  end
end
