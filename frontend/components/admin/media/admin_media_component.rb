module AdminMediaComponent
  extend ComponentHelper

  property :media, required: true
  property :link, default: true

  def link?
    @link
  end

  def image
    begin
      @media.variant(resize: "150x150").processed.rails_representation_url
    rescue ActiveStorage::InvariableError
      @media.rails_representation_url
    end
  end
end
