module Xing
  class Job < Xing::Base

    def self.find(job_id, options={})
      request(:get, "/v1/jobs/#{job_id}", options)
    end

    def self.search(query, options={})
      request(:get, '/v1/jobs/find', {:query => query}.merge(options))
    end

    def self.recommendations(options={})
      request(:get, '/v1/users/me/jobs/recommendations', options)
    end

  end
end
