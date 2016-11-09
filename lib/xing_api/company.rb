module XingApi
  class Company < XingApi::Base
    def self.find(company_id, options = {})
      request(:get, "/v1/companies/#{company_id}", options)
    end

    def self.search(keywords, options = {})
      request(:get, '/v1/companies/find', { keywords: keywords }.merge(options))
    end

    def self.unfollow(company_id, options = {})
      request(:delete, "/v1/companies/#{company_id}/follow", options)
    end

    def self.follow(company_id, options = {})
      request(:put, "/v1/companies/#{company_id}/follow", options)
    end

    def self.employees(company_id, options = {})
      request(:get, "/v1/companies/#{company_id}/employees", options)
    end

    def self.contacts(company_id, options = {})
      request(:get, "/v1/companies/#{company_id}/contacts", options)
    end
  end
end
