describe XingApi::User::Company do

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expected_params = {
        :name => 'Microsoft UG',
        :title => 'CEO',
        :industry => 'COMPUTER_SOFTWARE',
        :employment_type => 'OWNER'
      }

      expect_request(:post, '/v1/users/me/professional_experience/companies', expected_params)

      described_class.create('Microsoft UG', 'CEO', 'COMPUTER_SOFTWARE', 'OWNER')
    end
  end

  describe '.update' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/professional_experience/companies/42', {})

      described_class.update(42)
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/professional_experience/companies/42', {})

      described_class.delete(42)
    end
  end

  describe '.primary_company' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/professional_experience/primary_company', { :company_id => 42 })

      described_class.primary_company(42)
    end
  end

end
