module Komposable
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    def self.human_enum_name(enum_name, enum_value)
      key = [
        'activerecord',
        'attributes',
        model_name.i18n_key,
        enum_name.to_s.pluralize
      ]
      I18n.t(enum_value, scope: key.join('.'))
    end
  end
end
