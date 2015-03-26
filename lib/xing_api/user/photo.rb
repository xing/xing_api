module XingApi
  class User
    class Photo < XingApi::Base
      def self.update(body_hash, options = {})
        request_with_body(:put, '/v1/users/me/photo', body_hash, options)
      end

      def self.delete(options = {})
        request(:delete, '/v1/users/me/photo', options)
      end
    end
  end
end
