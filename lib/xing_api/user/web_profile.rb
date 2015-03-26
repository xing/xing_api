module XingApi
  class User
    class WebProfile < XingApi::Base
      def self.delete(profile, options = {})
        request(:delete, "/v1/users/me/web_profiles/#{profile}", options)
      end
    end
  end
end
