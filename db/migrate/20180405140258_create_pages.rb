class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :internal_name, unique: true
      t.string :slug
      t.text :description
      t.references :pageable, polymorphic: true

      t.timestamps
    end
  end
end
