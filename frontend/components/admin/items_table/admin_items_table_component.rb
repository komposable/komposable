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

  private

  def controller_namespace
    params[:controller].split('/').first
  end
end
