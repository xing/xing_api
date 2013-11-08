module XingApi
  class Invite < XingApi::Base

    def self.create(emails, options={})
      request(:post, '/v1/users/invite', {:to_emails => emails}.merge(options))
    end

  end
end
