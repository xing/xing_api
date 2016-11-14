describe XingApi::Company::Update do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/companies/some_id/updates', {})

      described_class.list('some_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expected_params = {
        headline: 'My headline',
        content:  'My content'
      }

      expect_request(:post, '/v1/companies/some_id/updates', expected_params)

      described_class.create('some_id', 'My headline', 'My content')
    end
  end

  describe '.edit' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/companies/updates/some_id', headline: 'My new headline')

      described_class.edit('some_id', headline: 'My new headline')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/companies/updates/some_id', {})

      described_class.delete('some_id')
    end
  end

  describe '.like' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/companies/updates/some_id/like', {})

      described_class.like('some_id')
    end
  end

  describe '.unlike' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/companies/updates/some_id/like', {})

      described_class.unlike('some_id')
    end
  end
end
