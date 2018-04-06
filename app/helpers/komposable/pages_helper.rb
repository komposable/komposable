module Komposable
  module PagesHelper
    def frontend_page_url(page)
      return nil unless page.pageable.respond_to? :to_frontend_url
      page.pageable.to_frontend_url
    end
  end
end
