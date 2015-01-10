module XingApi
  class User::Qualification < XingApi::Base

    def self.create(description, options={})
      request(
        :post,
        '/v1/users/me/educational_background/qualifications',
        { :description => description }.merge(options)
      )
    end

  end
end
