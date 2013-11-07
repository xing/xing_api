describe Xing::Job do
  describe '.find' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/jobs/job_id', {})

      described_class.find('job_id')
    end
  end

  describe '.search' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/jobs/find', {:query => 'search query'})

      described_class.search('search query')
    end
  end

  describe '.recommendations' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/jobs/recommendations', {})

      described_class.recommendations
    end
  end
end
