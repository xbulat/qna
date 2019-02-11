class AddAuthodIdToAnswer < ActiveRecord::Migration[5.2]
  def change
    add_reference :answers, :user, foreign_key: true
    change_column_null(:answers, :user_id, false)
  end
end
