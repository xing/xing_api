describe Xing::Conversation do
  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/me/conversations', {
        :recipient_ids => 'recipients',
        :subject => 'subject',
        :content => 'content'}
      )

      Xing::Conversation.create('recipients', 'subject', 'content')
    end
  end
end
