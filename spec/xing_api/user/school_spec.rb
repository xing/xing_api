describe XingApi::User::School do
  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/me/educational_background/schools', name: 'Springfield Elementary School')

      described_class.create('Springfield Elementary School')
    end
  end

  describe '.update' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/educational_background/schools/42', {})

      described_class.update(42)
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/users/me/educational_background/schools/42', {})

      described_class.delete(42)
    end
  end

  describe '.primary_school' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/educational_background/schools', school_id: 42)

      described_class.primary_school(42)
    end
  end
end
