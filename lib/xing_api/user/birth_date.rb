module XingApi
  class User
    class BirthDate < XingApi::Base
      def self.update(day, month, year, options = {})
        request(
          :put,
          '/v1/users/me/birth_date',
          {
            day: day,
            month: month,
            year: year
          }.merge(options)
        )
      end
    end
  end
end
