describe Xing::Activity do
  describe '.find' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/activities/123', {})

      described_class.find('123')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/activities/123', {})

      described_class.delete('123')
    end
  end

  describe '.share' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/activities/123/share', {})

      described_class.share('123')
    end
  end
end
