module XingApi
  class Activity < XingApi::Base

    def self.find(activity_id, options={})
      request(:get, "/v1/activities/#{activity_id}", options)
    end

    def self.delete(activity_id, options={})
      request(:delete, "/v1/activities/#{activity_id}", options)
    end

    def self.share(activity_id, options={})
      request(:post, "/v1/activities/#{activity_id}/share", options)
    end

  end
end
