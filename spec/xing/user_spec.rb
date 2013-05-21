describe Xing::User do
  describe '.find' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me', {})

      Xing::User.find('me')
    end
  end

  describe '.me' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/users/me', {})

      Xing::User.me
    end
  end

end
