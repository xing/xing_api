module Xing
  class Conversation < Xing::Base

    def self.create(recipient_ids, subject, content, options={})
      request(:post, '/v1/users/me/conversations', {
        :recipient_ids => recipient_ids,
        :subject => subject,
        :content => content
      }.merge(options))
    end

  end
end
