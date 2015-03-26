module XingApi
  class User
    class BusinessAddress < XingApi::Base
      def self.update(options = {})
        request(:put, '/v1/users/me/business_address', options)
      end
    end
  end
end
