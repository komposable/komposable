module AdminHeaderComponent
  extend ComponentHelper
  include Admin::NavigationConcern

  def current_controller?(c)
    "komposable/#{c}" == controller_path || "admin/#{c}" == controller_path
  end
end
