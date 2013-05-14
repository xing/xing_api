describe Xing::User do
  describe ".find" do
    it_behaves_like "a Xing API call" do
      let(:method) { :find }
      let(:verb) { :get }
    end

    it "should invoke the correct API call" do
      Xing::Client.any_instance.expects(:get).with('/v1/users/me', {})

      Xing::User.find("me")
    end
  end

  describe ".me" do
    it_behaves_like "a Xing API call" do
      let(:method) { :me }
      let(:verb) { :get }
    end

    it "should invoke the correct API call" do
      Xing::Client.any_instance.expects(:get).with('/v1/users/me', {})

      Xing::User.me
    end
  end

end
