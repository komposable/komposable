module AdminItemsTableComponent
  extend ComponentHelper

  property :columns, default: [:title]
  property :default_action, default: :show

  def edit_path(item)
    if controller_namespace != 'komposable'
      [:edit, controller_namespace, item]
    else
      [:edit, item]
    end
  end

  def item_path(item)
    if controller_namespace != 'komposable'
      [controller_namespace, item]
    else
      item
    end
  end

  def column_label(column)
    label = column.first if column.is_a? Array
    label ||= column

    case label
    when Symbol then label.to_s.humanize
    else label
    end
  end

  def columns_count
    @columns.size + 1
  end

  def cell(item, column)
    attribute = cell_attribute(column)
    value = cell_value(item, attribute)

    case value
    when nil                          then content_tag(:em, 'none')
    when true                         then component("admin/icon", icon: "check")
    when false                        then component("admin/icon", icon: "x")
    when ActiveStorage::Attached::One then image_tag url_for(value)
    when ApplicationRecord            then value.to_label
    else value
    end
  end

  def button_view?(item)
    item.respond_to?(:to_frontend_url) && item.to_frontend_url.present?
  end

  private

  def controller_namespace
    params[:controller].split('/').first
  end

  def cell_attribute(column)
    case column
    when Array then column.last
    else column
    end
  end

  def cell_value(item, attribute)
    case attribute
    when Proc   then attribute.call(item)
    when Symbol then item.public_send(attribute)
    else attribute
    end
  end
end
