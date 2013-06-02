module Xing
  class Contact < Xing::Base

    def self.list(user_id, options={})
      request(:get, "/v1/users/#{user_id}/contacts", options)
    end

    def self.shared(user_id, options={})
      request(:get, "/v1/users/#{user_id}/contacts/shared", options)
    end

  end
end
