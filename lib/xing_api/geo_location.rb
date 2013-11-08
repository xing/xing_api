module XingApi
  class GeoLocation < XingApi::Base

    def self.create(accuracy, latitude, longitude, options={})
      request(:put, '/v1/users/me/geo_location', {
        :accuracy => accuracy,
        :latitude => latitude,
        :longitude => longitude
      }.merge(options))
    end

    def self.nearby_users(options={})
      request(:get, '/v1/users/me/nearby_users', options)
    end

  end
end
