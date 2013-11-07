describe Xing::Activity::Like do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/activities/activity_id/likes', {})

      described_class.list('activity_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/activities/activity_id/likes', {})

      described_class.create('activity_id')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/activities/activity_id/likes', {})

      described_class.delete('activity_id')
    end
  end
end
