module Xing
  class Contact < Xing::Base

    def self.list(id, options={})
      request(:get, "/v1/users/#{id}/contacts", options)
    end

  end
end
