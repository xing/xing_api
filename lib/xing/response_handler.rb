module Xing
  module ResponseHandler

    def handle(response)
      return {} if response.code.to_i == 204

      unless (200..299).include?(response.code.to_i)
        raise_failed_response!(response)
      end

      JSON.parse(response.body.to_s, :symbolize_names => true)
    rescue JSON::ParserError => e
      raise Xing::Errors::JsonParse.new(e.message)
    end

    private

    def raise_failed_response!(response)
      body = JSON.parse(response.body.to_s, :symbolize_names => true)
      raise Xing::Errors::FailedResponse.new(response.code.to_i, body[:error_name], body[:message])
    rescue JSON::ParserError
      raise Xing::Errors::FailedResponse.new(response.code.to_i, '', response.body.to_s)
    end

  end
end
