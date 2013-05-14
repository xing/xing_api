describe Xing::Base do
  [:get, :post, :put, :delete].each do |http_verb|
    describe "self.#{http_verb}" do
      it "should call #{http_verb} with all parameters on the specified client" do
        client = stub
        client.expects(http_verb).with('url', {:some => 'parameter'})

        described_class.send(http_verb, 'url', {:some => 'parameter', :client => client})
      end

      it "should call #{http_verb} with all parameters on the default client" do
        client = stub
        Xing::Base.stubs(:default_client).returns(client)
        client.expects(http_verb).with('url', {:some => 'parameter'})

        described_class.send(http_verb, 'url', {:some => 'parameter'})
      end
    end
  end
end
