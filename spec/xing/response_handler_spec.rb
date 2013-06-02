describe Xing::ResponseHandler do
  include Xing::ResponseHandler

  describe '.handle' do
    it 'returns an empty hash for a 204 response' do
      response = stub(:code => '204')

      expect(handle(response)).to be_eql({})
    end

    it 'returns the parsed body for success response' do
      response = stub(
        :code => '200',
        :body => '{"some":"json"}'
      )

      expect(handle(response)).to be_eql({:some => 'json'})
    end

    it 'raises an error for invalid json body' do
      response = stub(
        :code => '200',
        :body => 'invalid json'
      )

      expect{handle(response)}.to raise_error(Xing::Errors::JsonParse)
    end

    it 'raises an error for failure response' do
      response = stub(:code => '403', :body => '')

      expect{handle(response)}.to raise_error(Xing::Errors::FailedResponse)
    end

    it 'includes error information for failed responses' do
      response = stub(
        :code => '403',
        :body => '{"error_name":"SOME_ERROR","message":"some message"}'
      )

      begin
        handle(response)
      rescue Xing::Errors::FailedResponse => error
        expect(error.code).to be_eql(403)
        expect(error.name).to be_eql('SOME_ERROR')
        expect(error.text).to be_eql('some message')
      end
    end

    it 'includes error information for failed response with no json body' do
      response = stub(
        :code => '403',
        :body => 'some error'
      )

      begin
        handle(response)
      rescue Xing::Errors::FailedResponse => error
        expect(error.code).to be_eql(403)
        expect(error.name).to be_eql('')
        expect(error.text).to be_eql('some error')
      end
    end
  end
end
