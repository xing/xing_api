describe Xing::Conversation do
  describe ".create" do
    it_behaves_like "a Xing API call" do
      let(:method) { :create }
    end

    it "should invoke the correct API call" do
      Xing::Client.any_instance.expects(:request).with do |*params|
        params[0] == :post &&
        params[1] == '/v1/users/me/conversations'
      end

      Xing::Conversation.create('recipients', 'subject', 'content')
    end
  end
end
