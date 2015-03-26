module XingApi
  class Conversation
    class Attachment < XingApi::Base
      def self.list(conversation_id, options = {})
        request(:get, "/v1/users/me/conversations/#{conversation_id}/attachments", options)
      end

      def self.download_url(conversation_id, attachment_id, options = {})
        request(:post, "/v1/users/me/conversations/#{conversation_id}/attachments/#{attachment_id}/download", options)
      end
    end
  end
end
