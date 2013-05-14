describe Xing::Contact do
  describe ".list" do
    it_behaves_like "a Xing API call" do
      let(:method) { :list }
      let(:verb) { :get }
    end

    it "should invoke the correct API call" do
      Xing::Client.any_instance.expects(:get).with('/v1/users/me/contacts', {})

      Xing::Contact.list("me")
    end
  end
end
