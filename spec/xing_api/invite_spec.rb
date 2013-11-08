describe XingApi::Invite do
  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/invite', {:to_emails => 'some@address.com'})

      described_class.create('some@address.com')
    end
  end
end
