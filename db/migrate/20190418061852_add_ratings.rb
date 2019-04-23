class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :score, null: false, default: 0
      t.timestamps
      t.belongs_to :linkable, polymorphic: true
    end
  end
end
