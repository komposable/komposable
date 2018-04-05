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

  def cell(item, column)
    value = item.public_send(column)

    case value
    when ActiveStorage::Attached::One
      image_tag url_for(value)
    else
      value
    end
  end

  private

  def controller_namespace
    params[:controller].split('/').first
  end
end
