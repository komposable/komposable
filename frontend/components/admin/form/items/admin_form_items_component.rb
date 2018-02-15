module AdminFormItemsComponent
  extend ComponentHelper

  def random_id
    @random_id ||= SecureRandom.hex(3)
  end

  def item_background_image(item)
    return "" unless item.image&.attached?
    "background-image: url(#{url_for(item.image.variant(resize: "x100"))})"
  end
end
