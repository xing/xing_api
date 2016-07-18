describe XingApi::Group::MediaPreview do
  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/groups/media_previews', url: 'some url')

      described_class.create('some url')
    end
  end
end
