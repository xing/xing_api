describe XingApi::Company do
  describe '.find' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/companies/some_id', {})

      described_class.find('some_id')
    end
  end

  describe '.search' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/companies/find', keywords: 'keywords')

      described_class.search('keywords')
    end
  end

  describe '.unfollow' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/companies/some_id/follow', {})

      described_class.unfollow('some_id')
    end
  end

  describe '.follow' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/companies/some_id/follow', {})

      described_class.follow('some_id')
    end
  end

  describe '.employees' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/companies/some_id/employees', {})

      described_class.employees('some_id')
    end
  end

  describe '.contacts' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/companies/some_id/contacts', {})

      described_class.contacts('some_id')
    end
  end
end
