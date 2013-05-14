module Xing
  class User < Xing::Base

    def self.find(id, options={})
      get "/v1/users/#{id}", options
    end

    def self.me(options={})
      find('me', options)
    end

  end
end
