module AdminMediaComponent
  extend ComponentHelper

  property :media, required: true
  property :link, default: true

  def link?
    @link
  end

  def image
    begin
      @media.variant(resize: "150x150")
    rescue ActiveStorage::InvariableError
      @media
    end
  end
end
