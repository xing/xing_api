module XingApi
  class Conversation < XingApi::Base

    def self.list(options={})
      request(:get, '/v1/users/me/conversations', options)
    end

    def self.find(conversation_id, options={})
      request(:get, "/v1/users/me/conversations/#{conversation_id}", options)
    end

    def self.create(recipient_ids, subject, content, options={})
      request(:post, '/v1/users/me/conversations', {
        :recipient_ids => recipient_ids,
        :subject => subject,
        :content => content
      }.merge(options))
    end

    def self.delete(conversation_id, options={})
      request(:delete, "/v1/users/me/conversations/#{conversation_id}", options)
    end

    def self.valid_recipient(recipient_id, options={})
      request(:get, "/v1/users/me/conversations/valid_recipients/#{recipient_id}", options)
    end

    def self.invite(conversation_id, user_id, options={})
      request(:put, "/v1/users/me/conversations/#{conversation_id}/participants/#{user_id}", options)
    end

    def self.read(conversation_id, options={})
      request(:put, "/v1/users/me/conversations/#{conversation_id}/read", options)
    end

  end
end
