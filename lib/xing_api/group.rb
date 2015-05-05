module XingApi
  class Group < XingApi::Base
    def self.search(keywords, options = {})
      request(:get, '/v1/groups/find', { keywords: keywords }.merge(options))
    end
  end
end
