module XingApi
  class User::School < XingApi::Base

    def self.create(name, options={})
      request(:post, '/v1/users/me/educational_background/schools', { :name => name }.merge(options))
    end

    def self.update(school_id, options={})
      request(:put, "/v1/users/me/educational_background/schools/#{school_id}", options)
    end

    def self.delete(school_id, options={})
      request(:delete, "/v1/users/me/educational_background/schools/#{school_id}", options)
    end

    def self.primary_school(school_id, options={})
      request(:put, '/v1/users/me/educational_background/schools', { :school_id => school_id }.merge(options))
    end

  end
end
