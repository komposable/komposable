class RichTextBlock < Komposable::ApplicationRecord
  belongs_to :parent, polymorphic: true

  def self.permitted_attributes
    [:id, :text, :position, :_destroy]
  end

  def to_partial_path
    "components/rich_text_block/rich_text_block"
  end

  def to_component_attributes
    attributes
  end

  def block_name
    "Rich text"
  end

  def block_icon
    "align-left"
  end
end
