describe Xing::Conversation::Attachment do
  describe '.list' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/conversations/conversation_id/attachments', {})

      described_class.list('conversation_id')
    end
  end

  describe '.find' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/conversations/conversation_id/attachments/attachment_id', {})

      described_class.find('conversation_id', 'attachment_id')
    end
  end

  describe '.download_url' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/me/conversations/conversation_id/attachments/message_id/download', {})

      described_class.download_url('conversation_id', 'message_id')
    end
  end
end
