describe Xing::Conversation do
  describe ".list" do
    it_behaves_like "a Xing API call" do
      let(:method) { :create }
      let(:verb) { :post }
    end

    it "should invoke the correct API call" do
      Xing::Client.any_instance.expects(:post).with do |params|
        params == '/v1/users/me/conversations'
      end

      Xing::Conversation.create('recipients', 'subject', 'content')
    end
  end
end
