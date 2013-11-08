module XingApi
  class Activity::Like < XingApi::Base

    def self.list(activity_id, options={})
      request(:get, "/v1/activities/#{activity_id}/likes", options)
    end

    def self.create(activity_id, options={})
      request(:put, "/v1/activities/#{activity_id}/likes", options)
    end

    def self.delete(activity_id, options={})
      request(:delete, "/v1/activities/#{activity_id}/likes", options)
    end

  end
end
