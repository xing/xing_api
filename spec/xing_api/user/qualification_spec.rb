describe XingApi::User::Qualification do

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/users/me/educational_background/qualifications', { :description => 'Professional Certificate in Supply Chain Management'})

      described_class.create('Professional Certificate in Supply Chain Management')
    end
  end

end
