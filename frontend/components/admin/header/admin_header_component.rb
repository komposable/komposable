module AdminHeaderComponent
  extend ComponentHelper

  def current_controller?(c)
    "komposable/#{c}" == controller_path || "admin/#{c}" == controller_path
  end

  def site_name
    # This name will be displayed in the header.
    t("site_name")
  end

  def items
    # These are the items that will be displayed in the main navigation.
    # Start the path with `[main_app, :admin, ...]` if the controller lives in the main app, or with `[komposable, ...]` if it's from the engine.
    return [] unless logged_in?

    Struct.new("Item", :text, :href)

    i = []

    # i << Struct::Item.new("Pages", [main_app, :admin, :pages]) if policy(Page).index?
    i << Struct::Item.new("Medias", [komposable, :medias]) #if policy(Media).index?
    i << Struct::Item.new("Users", [komposable, :users]) if policy(User).index?

    i
  end
end
