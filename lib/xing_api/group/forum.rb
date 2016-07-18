module XingApi
  class Group
    class Forum < XingApi::Base
      def self.list(group_id, options = {})
        request(:get, "/v1/groups/#{group_id}/forums", options)
      end
    end
  end
end
