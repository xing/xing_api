module XingApi
  class User
    class Company < XingApi::Base
      def self.create(name, title, industry, employment_type, options = {})
        request(
          :post,
          '/v1/users/me/professional_experience/companies',
          {
            name: name,
            title: title,
            industry: industry,
            employment_type: employment_type
          }.merge(options)
        )
      end

      def self.update(company_id, options = {})
        request(:put, "/v1/users/me/professional_experience/companies/#{company_id}", options)
      end

      def self.delete(company_id, options = {})
        request(:delete, "/v1/users/me/professional_experience/companies/#{company_id}", options)
      end

      def self.primary_company(company_id, options = {})
        request(
          :put,
          '/v1/users/me/professional_experience/primary_company',
          { company_id: company_id }.merge(options)
        )
      end

      def self.recommendations(options = {})
        request(:get, '/v1/companies/recommendations', options)
      end

      def self.following(options = {})
        request(:get, '/v1/users/me/companies/following', options)
      end

      def self.managing(options = {})
        request(:get, '/v1/users/me/companies/managing', options)
      end
    end
  end
end
