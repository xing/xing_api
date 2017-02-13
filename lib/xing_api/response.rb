require 'delegate'

module XingApi
  class Response < SimpleDelegator
    attr_reader :headers

    def initialize(body, headers)
      @headers = headers

      body =
        begin
          JSON.parse(body, symbolize_names: true)
        rescue JSON::ParserError
          {}
        end

      super(body)
    end
  end
end
