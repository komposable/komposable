# Monkey patch to fix routes problem in mounted engine
# see https://github.com/kaminari/kaminari/issues/457#issuecomment-27781106

module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        (@options[:routes_proxy] || @template).url_for @params.merge(@param_name => (page <= 1 ? nil : page))
      end
    end
  end
end
