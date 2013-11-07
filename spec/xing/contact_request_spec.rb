describe Xing::ContactRequest do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/contact_requests', {})

      described_class.list
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/user_id/contact_requests', {})

      described_class.create('user_id')
    end
  end

  describe '.accept' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/recipient_id/contact_requests/me/accept', {})

      described_class.accept('recipient_id')
    end
  end

  describe '.deny' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/contact_requests/sender_id', {})

      described_class.deny('sender_id')
    end
  end

  describe '.sent' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/contact_requests/sent', {})

      described_class.sent
    end
  end
end
