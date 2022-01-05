class AddEventToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :attending_id, :integer, index: true
    add_foreign_key :users, :events, column: :attending_id, null: false
  end
end
