module XingApi
  class User
    class PrivateAddress < XingApi::Base
      def self.update(options = {})
        request(:put, '/v1/users/me/private_address', options)
      end
    end
  end
end
