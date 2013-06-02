module Xing
  class Conversation::Message < Xing::Base

    def self.list(conversation_id, options={})
      request(:get, "/v1/users/me/conversations/#{conversation_id}/messages", options)
    end

    def self.create(conversation_id, content, options={})
      request(:post, "/v1/users/me/conversations/#{conversation_id}/messages", {:content => content}.merge(options))
    end

    def self.find(conversation_id, message_id, options={})
      request(:get, "/v1/users/me/conversations/#{conversation_id}/messages/#{message_id}", options)
    end

    def self.read(conversation_id, message_id, options={})
      request(:put, "/v1/users/me/conversations/#{conversation_id}/messages/#{message_id}/read", options)
    end

    def self.unread(conversation_id, message_id, options={})
      request(:delete, "/v1/users/me/conversations/#{conversation_id}/messages/#{message_id}/read", options)
    end

  end
end
