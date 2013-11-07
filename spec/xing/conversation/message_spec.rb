describe Xing::Conversation::Message do
  describe '.list' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/conversations/conversation_id/messages', {})

      described_class.list('conversation_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/me/conversations/conversation_id/messages', {:content => 'message'})

      described_class.create('conversation_id', 'message')
    end
  end

  describe '.find' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/conversations/conversation_id/messages/message_id', {})

      described_class.find('conversation_id', 'message_id')
    end
  end

  describe '.read' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/conversations/conversation_id/messages/message_id/read', {})

      described_class.read('conversation_id', 'message_id')
    end
  end

  describe '.unread' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/conversations/conversation_id/messages/message_id/read', {})

      described_class.unread('conversation_id', 'message_id')
    end
  end
end
