module LocaleSetter
  module Rails
    def self.included(controller)
      if controller.respond_to?(:before_filter)
        controller.before_filter :set_locale
      end
    end

    def default_url_options(options = {})
      if i18n.locale == i18n.default_locale
        options
      else
        {LocaleSetter::URL_PARAM => i18n.locale}.merge(options)
      end
    end

    def i18n
      @i18n ||= I18n
    end

    def set_locale
      LocaleSetter::Generic.set_locale(
        i18n,
        {:params  => params,
         :user    => locale_user,
         :request => request.env}
      )
    end

    def locale_user
      if respond_to?(:current_user) && current_user
        current_user
      end
    end
  end
end