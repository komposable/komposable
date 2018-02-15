module AdminFormUploadComponent
  extend ComponentHelper

  property :record, required: true
  property :attachment, required: true
  property :form, required: true

  def attachment?
    record_attachment&.attached?
  end

  def attachment_url
    url_for(record_attachment.variant(resize: "520"))
  end

  def record_attachment
    @record.public_send(@attachment)
  end

end
