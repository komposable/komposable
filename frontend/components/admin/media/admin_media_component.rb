module AdminMediaComponent
  extend ComponentHelper

  property :media, required: true

  def image
    begin
      @media.variant(resize: "150x150").processed.service_url
    rescue ActiveStorage::InvariableError
      @media.service_url
    end
  end
end
