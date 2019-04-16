class AddLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :name
      t.string :url
      t.timestamps
      t.belongs_to :linkable, polymorphic: true
    end
  end
end
