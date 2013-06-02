module Xing
  class Activity::Comment < Xing::Base

    def self.list(activity_id, options={})
      request(:get, "/v1/activities/#{activity_id}/comments", options)
    end

    def self.create(activity_id, comment, options={})
      request(:post, "/v1/activities/#{activity_id}/comments", {:text => comment}.merge(options))
    end

    def self.delete(activity_id, comment_id, options={})
      request(:delete, "/v1/activities/#{activity_id}/comments/#{comment_id}", options)
    end

  end
end
