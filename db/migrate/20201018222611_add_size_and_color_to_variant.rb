class AddSizeAndColorToVariant < ActiveRecord::Migration[5.2]
  def change
    add_references :variants, :color, foreign_key: true
    add_references :variants, :size, foreign_key: true
  end
end
