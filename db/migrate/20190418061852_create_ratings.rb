class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :score, null: false, default: 0
      t.references :user, foreign_key: true
      t.belongs_to :linkable, polymorphic: true
      t.timestamps
    end
  end
end
