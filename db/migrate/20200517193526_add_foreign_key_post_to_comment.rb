class AddForeignKeyPostToComment < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :comments, :posts, on_delete: :cascade
    add_foreign_key :comments, :users, on_delete: :cascade
  end
end
