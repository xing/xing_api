describe Xing::GeoLocation do
  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/geo_location', {
        :accuracy => 'acc',
        :latitude => 'lat',
        :longitude => 'long'
      })

      described_class.create('acc', 'lat', 'long')
    end
  end

  describe '.nearby_users' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/nearby_users', {})

      described_class.nearby_users
    end
  end
end
