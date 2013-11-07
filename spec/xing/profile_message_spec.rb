describe Xing::ProfileMessage do
  describe '.find' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/user_id/profile_message', {})

      described_class.find('user_id')
    end
  end

  describe '.update' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/profile_message', {:message => 'message'})

      described_class.update('message')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:put, '/v1/users/me/profile_message', {:message => ''})

      described_class.delete
    end
  end
end
