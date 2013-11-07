describe Xing::User do
  describe '.find' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me', {})

      described_class.find('me')
    end
  end

  describe '.me' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me', {})

      described_class.me
    end
  end

  describe '.id_card' do
    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/id_card', {})

      described_class.id_card
    end
  end

  describe '.shared' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/Other_User/contacts/shared', {})

      described_class.shared('Other_User')
    end
  end

  describe '.paths' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me/network/Other_User/paths', {})

      described_class.paths('Other_User')
    end
  end

  describe '.find_by_emails' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/find_by_emails', {:emails => 'some@address.com'})

      described_class.find_by_emails('some@address.com')
    end
  end

  describe '.status_message' do
    it_behaves_like 'a Xing API call with optional parameters'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/me/status_message', {:message => 'message'})

      described_class.status_message('message')
    end
  end
end
