module AdminButtonComponent
  extend ComponentHelper

  property :tag, default: "button"
  property :type, default: "button"

  def element
    { tag: @tag, type: @type, class: modifiers, data: @data, title: @title, name: @name, aria: @aria }
  end

  def modifiers
    classnames("admin-button", @modifiers, "has-icon": icon?, "has-icon-only": icon_only?)
  end

  def link?
    @href.present?
  end

  def icon?
    @icon.present?
  end

  def icon_only?
    icon? && @text.nil?
  end
end
