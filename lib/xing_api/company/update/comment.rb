module XingApi
  class Company
    class Update
      class Comment < XingApi::Base
        def self.list(update_id, options = {})
          request(:get, "/v1/companies/updates/#{update_id}/comments", options)
        end

        def self.create(update_id, content, options = {})
          request(
            :post,
            "/v1/companies/updates/#{update_id}/comments",
            { content: content }.merge(options)
          )
        end

        def self.delete(update_id, comment_id, options = {})
          request(
            :delete,
            "/v1/companies/updates/#{update_id}/comments/#{comment_id}",
            options
          )
        end
      end
    end
  end
end
