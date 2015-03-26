describe XingApi::Activity::Comment do
  describe '.list' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:get, '/v1/activities/activity_id/comments', {})

      described_class.list('activity_id')
    end
  end

  describe '.create' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:post, '/v1/activities/activity_id/comments', text: 'my comment')

      described_class.create('activity_id', 'my comment')
    end
  end

  describe '.delete' do
    it_behaves_like 'a Xing API call'

    it 'invokes the correct API call' do
      expect_request(:delete, '/v1/activities/activity_id/comments/comment_id', {})

      described_class.delete('activity_id', 'comment_id')
    end
  end
end
