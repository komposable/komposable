module AdminButtonComponent
  extend ComponentHelper

  property :tag, default: "button"
  property :type, default: "button"

  def element
    {
      aria: @aria,
      class: modifiers,
      data: @data,
      name: @name, 
      tag: @tag,
      title: @title,
      type: @type,
      value: @value
    }
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
