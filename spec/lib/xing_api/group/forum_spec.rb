describe XingApi::Group::Forum do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/groups/some_id/forums', {})

      described_class.list('some_id')
    end
  end
end
