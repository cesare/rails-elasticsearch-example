class CreateServants < ActiveRecord::Migration[6.0]
  def change
    create_table :servants do |t|
      t.string :name, null: false
      t.string :class_label, null: false
      t.integer :rarity, null: false
      t.timestamps
    end
  end
end
