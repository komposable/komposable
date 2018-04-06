module AdminItemsTableComponent
  extend ComponentHelper

  property :columns, default: [:title]

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
    case column
    when Array
      column.last
    else
      column.to_s.humanize
    end
  end

  def cell(item, column)
    attribute = cell_attribute(column)
    value = item.public_send(attribute)

    case value
    when ActiveStorage::Attached::One
      image_tag url_for(value)
    else
      value
    end
  end

  def button_view?(item)
    item.is_a?(Page) && respond_to?(:frontend_page_url) && frontend_page_url(item)
  end

  private

  def controller_namespace
    params[:controller].split('/').first
  end

  def cell_attribute(column)
    case column
    when Array
      column.first
    else
      column
    end
  end
end
