module Xing
  module Errors
    class FailedResponse < Base
      attr_reader :code, :name, :text

      def initialize(code, name = '', text = '')
        @code = code
        @name = name
        @text = text
        super(text)
      end

      def to_s
        [code, name, text].join(' - ')
      end

    end
  end
end
