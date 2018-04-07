module AdminItemsGridComponent
  extend ComponentHelper

  def grid_component(item)
    c @component, "#{@component_key}": item
  end
end
