describe XingApi::User::BirthDate do
  describe '.update' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expected_params = {
        day: 28,
        month: 8,
        year: 1957
      }

      expect_request(:put, '/v1/users/me/birth_date', expected_params)

      described_class.update(28, 8, 1957)
    end
  end
end
