describe XingApi::Conversation do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/conversations', {})

      described_class.list
    end
  end

  describe '.find' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/conversations/conversation_id', {})

      described_class.find('conversation_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/me/conversations', {
        :recipient_ids => 'recipients',
        :subject => 'subject',
        :content => 'content'}
      )

      described_class.create('recipients', 'subject', 'content')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/conversations/conversation_id', {})

      described_class.delete('conversation_id')
    end
  end

  describe '.valid_recipient' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/conversations/valid_recipients/user_id', {})

      described_class.valid_recipient('user_id')
    end
  end

  describe '.invite' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/conversations/conversation_id/participants/user_id', {})

      described_class.invite('conversation_id', 'user_id')
    end
  end

  describe '.read' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/conversations/conversation_id/read', {})

      described_class.read('conversation_id')
    end
  end
end
