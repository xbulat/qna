class AddAuthodIdToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :user, foreign_key: true
    change_column_null(:questions, :user_id, false)
  end
end
