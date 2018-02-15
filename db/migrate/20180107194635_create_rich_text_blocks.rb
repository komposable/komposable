class CreateRichTextBlocks < ActiveRecord::Migration[5.2]
  def up
    create_table :rich_text_blocks do |t|
      t.references :parent, polymorphic: true
      t.integer :position
      t.text :text
      t.timestamps
    end
  end

  def down
    drop_table :rich_text_blocks
  end
end
