module LocaleSetter
  module User
    def self.for(user, available)
      if user && user.respond_to?(:locale) && user.locale && !user.locale.empty?
        LocaleSetter::Matcher.match(user.locale, available)
      end
    end
  end
end