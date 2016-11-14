module XingApi
  class Company
    class Update < XingApi::Base
      def self.list(company_id, options = {})
        request(:get, "/v1/companies/#{company_id}/updates", options)
      end

      def self.create(company_id, headline, content, options = {})
        request(
          :post,
          "/v1/companies/#{company_id}/updates",
          {
            headline: headline,
            content: content
          }.merge(options)
        )
      end

      def self.edit(update_id, options = {})
        request(:put, "/v1/companies/updates/#{update_id}", options)
      end

      def self.delete(update_id, options = {})
        request(:delete, "/v1/companies/updates/#{update_id}", options)
      end

      def self.like(update_id, options = {})
        request(:put, "/v1/companies/updates/#{update_id}/like", options)
      end

      def self.unlike(update_id, options = {})
        request(:delete, "/v1/companies/updates/#{update_id}/like", options)
      end
    end
  end
end
