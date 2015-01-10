module XingApi
  class User::Language < XingApi::Base

    def self.update(language, options={})
      request(:put, "/v1/users/me/languages/#{language}", options)
    end

    def self.delete(language, options={})
      request(:delete, "/v1/users/me/languages/#{language}", options)
    end

  end
end
