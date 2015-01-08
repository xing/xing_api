module XingApi
  class Contact < XingApi::Base

    def self.list(user_id, options={})
      request(:get, "/v1/users/#{user_id}/contacts", options)
    end

    def self.list_ids(options={})
      request(:get, '/v1/users/me/contact_ids', options)
    end

    def self.shared(user_id, options={})
      request(:get, "/v1/users/#{user_id}/contacts/shared", options)
    end

  end
end
